import 'package:witchle/game/witchle.dart';

// Todo: sidebar with Loomlight info
// Todo: another board with 6 letter words, horizontally scrollable

// Status of game
enum GameStatus { playing, submitting, lost, won }

/// {@template GameScreen}
/// Represents the main game screen in the application.
/// It creates an instance of _GameScreenState to manage its state.
/// {@endtemplate}
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  // Returns an instance of the
  State<GameScreen> createState() => _GameScreenState();
}

/// {@template _GameScreenState}
/// Contaisn the logic and UI of the game screen
/// {@endtemplate}
class _GameScreenState extends State<GameScreen> {
  // PROPERTIES ////////////////////////////////////////////////////////////

  GameStatus _gameStatus = GameStatus.playing;

  int numLetters = 6,
      numGuesses = 6,
      _currentWordIndex = 0; // Current word index being constructed

  Word? get _currentWord =>
      _currentWordIndex < board.length ? board[_currentWordIndex] : null;

  Word _solution = Word.fromString(
    // Target word to guess
    // Random from list
    // TODO: implement 5 letters mode
    sixLetterWords[Random().nextInt(sixLetterWords.length)].toUpperCase(),
  );

  late List<Word> board = List.generate(numGuesses,
      (_) => Word(letters: List.generate(numLetters, (_) => Letter.empty())));

  late List<List<GlobalKey<FlipCardState>>> flipCardKeys = List.generate(
    numGuesses,
    (_) => List.generate(numLetters, (_) => GlobalKey<FlipCardState>()),
  );

  final Set<Letter> _keyboardLetters = {};

  // METHODS ////////////////////////////////////////////////////////////////

  // Adds a letter to the current word if the game is in the playing state
  void _onKeyTapped(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.addLetter(val));
    }
  }

  // Removes a letter from the current word
  void _onDeleteTapped() {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.removeLetter); //FIXME: NOT WORKING
    }
  }

  // Checks the current word against the solution and updates the game state
  Future<void> _onEnterTapped() async {
    // Async for flipcards to work
    if (_gameStatus == GameStatus.playing // Is playing
            &&
            _currentWord != null &&
            !_currentWord!.letters
                .contains(Letter.empty()) // All spaces are filled
        ) {
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
          () => flipCardKeys[_currentWordIndex][i].currentState?.toggleCard(),
        );
      }

      _checkIfWinOrLoss();
    }
  }

  // Determines if the player has won or lost and displays a message
  void _checkIfWinOrLoss() {
    // The word is the same as the solution
    if (_currentWord!.wordString == _solution.wordString) {
      _gameStatus = GameStatus.won; // Win status

      // Show Snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating, // Better looking
          dismissDirection: DismissDirection.none,
          duration: const Duration(days: 1),
          backgroundColor: correctColor,
          content: const Text(
            '¡Has acertado!',
            style: TextStyle(color: Colors.white),
          ),
          // Button
          action: SnackBarAction(
            onPressed: _restart,
            textColor: Colors.white,
            label: 'Otra palabra',
            backgroundColor: lighterCorrectColor,
          )));
    } else if (_currentWordIndex + 1 >= board.length) {
      _gameStatus = GameStatus.lost;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating, // Better looking
          dismissDirection: DismissDirection.none,
          duration: const Duration(days: 1),
          backgroundColor: incorrectColor,
          content: Text(
            'Has fallado. Solución: ${_solution.wordString.toUpperCase()}',
            style: const TextStyle(color: Colors.white),
          ),
          action: SnackBarAction(
            onPressed: _restart,
            textColor: Colors.white,
            label: 'Otra palabra',
            backgroundColor: lighterIncorrectColor,
          )));
    } else {
      _gameStatus = GameStatus.playing;
    }

    // Next letters will appear in next space
    _currentWordIndex++;
  }

  // Resets the game state for a new round
  void _restart() {
    setState(() {
      _gameStatus = GameStatus.playing;
      _currentWordIndex = 0;
      _keyboardLetters.clear();

      _solution = Word.fromString(
        sixLetterWords[Random().nextInt(sixLetterWords.length)].toUpperCase(),
      );

      board
        ..clear()
        ..addAll(
          List.generate(
            numGuesses,
            (_) =>
                Word(letters: List.generate(numLetters, (_) => Letter.empty())),
          ),
        );

      flipCardKeys
        ..clear()
        ..addAll(
          List.generate(
              numGuesses,
              (_) =>
                  List.generate(numLetters, (_) => GlobalKey<FlipCardState>())),
        );
    });
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  // Uses a Scaffold widget to create a layout with an AppBar and a body
  // containing a game board and a keyboard.
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // Centered title and transparent background
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('WITCHLE',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 15,
                ))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Adivina la palabra!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 30), // Spacing box
            Board(words: board, flipCards: flipCardKeys),
            const SizedBox(height: 20), // Spacing box
            Keyboard(
              onKeyTapped: _onKeyTapped,
              onDeleteTapped: _onDeleteTapped,
              onEnterTapped: _onEnterTapped,
              letters: _keyboardLetters,
            ),
          ],
        ));
  }
}
