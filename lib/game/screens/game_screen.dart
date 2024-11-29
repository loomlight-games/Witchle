import 'package:flutter/material.dart';
import 'package:witchle/game/exports.dart';

// Status of game
enum GameStatus { playing, submitting, lost, won }

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // PROPERTIES ////////////////////////////////////////////////////////////

  GameStatus _gameStatus = GameStatus.playing;

  // Access the singleton instance
  final SettingsManager settings = SettingsManager();

  // Use the selectedLetters and selectedGuesses from SettingsManager
  late final int numLetters = settings.selectedLetters;
  late final int numGuesses = settings.selectedGuesses;
  int currentWordIndex = 0; // Current word index being constructed

  Word? get _currentWord =>
      currentWordIndex < board.length ? board[currentWordIndex] : null;

  late Word _solution = _generateSolution();

  late List<Word> board = List.generate(numGuesses,
      (_) => Word(letters: List.generate(numLetters, (_) => Letter.empty())));

  late List<List<GlobalKey<FlipCardState>>> flipCardKeys = List.generate(
    numGuesses,
    (_) => List.generate(numLetters, (_) => GlobalKey<FlipCardState>()),
  );

  final Set<Letter> _keyboardLetters = {};

  // METHODS ////////////////////////////////////////////////////////////////

  // Generates a random solution word based on the number of letters
  Word _generateSolution() {
    final wordList = numLetters == 5 ? fiveLetterWords : sixLetterWords;
    return Word.fromString(
      wordList[Random().nextInt(wordList.length)].toUpperCase(),
    );
  }

  // Adds a letter to the current word if the game is in the playing state
  void _onKeyTapped(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.addLetter(val));
    }
  }

  // Removes a letter from the current word
  void _onDeleteTapped() {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.removeLetter());
    }
  }

  // Checks the current word against the solution and updates the game state
  Future<void> _onEnterTapped() async {
    if (_gameStatus == GameStatus.playing &&
        _currentWord != null &&
        !_currentWord!.letters.contains(Letter.empty())) {
      _gameStatus = GameStatus.submitting;

      for (var i = 0; i < _currentWord!.letters.length; i++) {
        final currentWordLetter = _currentWord!.letters[i];
        final currentSolutionLetter = _solution.letters[i];

        setState(() {
          if (currentWordLetter == currentSolutionLetter) {
            _currentWord!.letters[i] =
                currentWordLetter.copyWith(status: LetterStatus.correct);
          } else if (_solution.letters.contains(currentWordLetter)) {
            _currentWord!.letters[i] =
                currentWordLetter.copyWith(status: LetterStatus.inWord);
          } else {
            _currentWord!.letters[i] =
                currentWordLetter.copyWith(status: LetterStatus.notInWord);
          }
        });

        final letter = _keyboardLetters.firstWhere(
            (e) => e.value == currentWordLetter.value,
            orElse: () => Letter.empty());
        if (letter.status != LetterStatus.correct) {
          _keyboardLetters
              .removeWhere((e) => e.value == currentWordLetter.value);
          _keyboardLetters.add(_currentWord!.letters[i]);
        }

        await Future.delayed(
          const Duration(milliseconds: 150),
          () => flipCardKeys[currentWordIndex][i].currentState?.toggleCard(),
        );
      }

      _checkIfWinOrLoss();
    }
  }

  // Determines if the player has won or lost and displays a message
  void _checkIfWinOrLoss() {
    if (_currentWord!.wordString == _solution.wordString) {
      _gameStatus = GameStatus.won;
      _showSnackBar(correctColor, '¡Has acertado!', lighterCorrectColor);
    } else if (currentWordIndex + 1 >= board.length) {
      _gameStatus = GameStatus.lost;
      _showSnackBar(
          incorrectColor,
          'Has fallado.\nSolución: ${_solution.wordString.toUpperCase()}',
          lighterIncorrectColor);
    } else {
      _gameStatus = GameStatus.playing;
    }

    currentWordIndex++;
  }

  // Displays a SnackBar with a message
  void _showSnackBar(
      Color backgroundColor, String contentText, Color actionBackgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        duration: const Duration(days: 1),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  contentText,
                  style: const TextStyle(color: letterColor, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: SnackBarAction(
                onPressed: _restart,
                textColor: letterColor,
                label: 'Otra palabra',
                backgroundColor: actionBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Resets the game state for a new round
  void _restart() {
    setState(() {
      _gameStatus = GameStatus.playing;
      currentWordIndex = 0;
      _keyboardLetters.clear();
      _solution = _generateSolution();

      board = List.generate(
        numGuesses,
        (_) => Word(letters: List.generate(numLetters, (_) => Letter.empty())),
      );

      flipCardKeys = List.generate(
        numGuesses,
        (_) => List.generate(numLetters, (_) => GlobalKey<FlipCardState>()),
      );
    });
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  // Builds the main body of the game screen
  Column _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Board(words: board, flipCards: flipCardKeys),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 20.0), // Set the desired margin
          child: Keyboard(
            onKeyTapped: _onKeyTapped,
            onDeleteTapped: _onDeleteTapped,
            onEnterTapped: _onEnterTapped,
            letters: _keyboardLetters,
          ),
        ),
      ],
    );
  }
}
