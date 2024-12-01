import 'package:witchle/game/exports.dart';

// Enum to represent the status of the game
enum GameStatus { playing, submitting, lost, won }

// Main game screen widget
class GameScreen extends StatefulWidget {
  const GameScreen({super.key}); // Constructor for the GameScreen widget

  @override
  State<GameScreen> createState() =>
      _GameScreenState(); // Create the state for the GameScreen
}

// State class for the GameScreen
class _GameScreenState extends State<GameScreen> {
  // PROPERTIES ////////////////////////////////////////////////////////////

  GameStatus _gameStatus = GameStatus.playing; // Current status of the game

  // Access the singleton instance of SettingsManager
  final SettingsManager settings = SettingsManager();

  // Using the selectedLetters and selectedGuesses from SettingsManager
  /// Number of letters in the word
  late final int numLetters = settings.selectedLetters;

  /// Number of guesses allowed
  late final int numGuesses = settings.selectedGuesses;

  /// Index of the current word being constructed
  int currentWordIndex = 0;

  // Getter to retrieve the current word being constructed
  Word? get _currentWord =>
      currentWordIndex < board.length ? board[currentWordIndex] : null;

  // Generate a random solution word
  late Word _solution = _generateSolution();

  // Initialize the game board with empty words
  late List<Word> board = List.generate(
    numGuesses,
    (_) => Word(letters: List.generate(numLetters, (_) => Letter.empty())),
  );

  // Initialize keys for FlipCard widgets
  late List<List<GlobalKey<FlipCardState>>> flipCardKeys = List.generate(
    numGuesses,
    (_) => List.generate(numLetters, (_) => GlobalKey<FlipCardState>()),
  );

  final Set<Letter> _keyboardLetters = {}; // Set to track keyboard letters

  // METHODS ////////////////////////////////////////////////////////////////

  /// Generates a random solution word based on the number of letters
  Word _generateSolution() {
    final wordList = numLetters == 5
        ? fiveLetterWords
        : sixLetterWords; // Choose word list based on letter count
    return Word.fromString(
      wordList[Random().nextInt(wordList.length)]
          .toUpperCase(), // Randomly select a word and convert to uppercase
    );
  }

  /// Adds a letter to the current word if the game is in the playing state
  void _onKeyTapped(String val) {
    if (_gameStatus == GameStatus.playing) {
      // Check if the game is in the playing state
      setState(() =>
          _currentWord?.addLetter(val)); // Add the letter to the current word
    }
  }

  /// Removes a letter from the current word
  void _onDeleteTapped() {
    if (_gameStatus == GameStatus.playing) {
      // Check if the game is in the playing state
      setState(() => _currentWord
          ?.removeLetter()); // Remove the last letter from the current word
    }
  }

  /// Checks the current word against the solution and updates the game state
  Future<void> _onEnterTapped() async {
    if (_gameStatus == GameStatus.playing &&
        _currentWord != null &&
        !_currentWord!.letters.contains(Letter.empty())) {
      // Ensure the word is complete
      _gameStatus = GameStatus.submitting; // Update game status to submitting

      for (var i = 0; i < _currentWord!.letters.length; i++) {
        final currentWordLetter =
            _currentWord!.letters[i]; // Get the current letter
        final currentSolutionLetter =
            _solution.letters[i]; // Get the corresponding solution letter

        setState(() {
          if (currentWordLetter == currentSolutionLetter) {
            // If the letter is correct
            _currentWord!.letters[i] =
                currentWordLetter.copyWith(status: LetterStatus.correct);
          } else if (_solution.letters.contains(currentWordLetter)) {
            // If the letter is in the word but in the wrong position
            _currentWord!.letters[i] =
                currentWordLetter.copyWith(status: LetterStatus.inWord);
          } else {
            // If the letter is not in the word
            _currentWord!.letters[i] =
                currentWordLetter.copyWith(status: LetterStatus.notInWord);
          }
        });

        // Update the keyboard letter status
        final letter = _keyboardLetters.firstWhere(
            (e) => e.value == currentWordLetter.value,
            orElse: () => Letter.empty());
        if (letter.status != LetterStatus.correct) {
          _keyboardLetters
              .removeWhere((e) => e.value == currentWordLetter.value);
          _keyboardLetters.add(_currentWord!.letters[i]);
        }

        // Flip the card to reveal the letter status
        await Future.delayed(
          const Duration(milliseconds: 150),
          () => flipCardKeys[currentWordIndex][i].currentState?.toggleCard(),
        );
      }

      _checkIfWinOrLoss(); // Check if the game is won or lost
    }
  }

  /// Determines if the player has won or lost and displays a message
  void _checkIfWinOrLoss() {
    final currentWord = _currentWord; // Get the current word
    if (currentWord != null && currentWord.wordString == _solution.wordString) {
      // Check if the word matches the solution
      _updateGameStatus(
          GameStatus.won, correctColor, '¡Has acertado!', lighterCorrectColor);
    } else if (currentWordIndex + 1 >= board.length) {
      // Check if the player has used all guesses
      _updateGameStatus(
          GameStatus.lost,
          incorrectColor,
          'Has fallado.\nSolución: ${_solution.wordString.toUpperCase()}',
          lighterIncorrectColor);
    } else {
      _updateGameStatus(
          GameStatus.playing, null, null, null); // Continue playing
    }

    currentWordIndex++; // Move to the next word
  }

  /// Updates the game status and shows a SnackBar if needed
  void _updateGameStatus(GameStatus status, Color? backgroundColor,
      String? contentText, Color? actionBackgroundColor) {
    setState(() {
      _gameStatus = status; // Update the game status
    });
    if (backgroundColor != null &&
        contentText != null &&
        actionBackgroundColor != null) {
      _showSnackBar(backgroundColor, contentText,
          actionBackgroundColor); // Show a SnackBar with a message
    }
  }

  /// Displays a SnackBar with a message
  void _showSnackBar(
      Color backgroundColor, String contentText, Color actionBackgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior:
            SnackBarBehavior.floating, // Floating behavior for the SnackBar
        dismissDirection: DismissDirection.none, // Disable dismiss direction
        duration: const Duration(days: 1), // Set a long duration
        backgroundColor: backgroundColor, // Set the background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        margin: const EdgeInsets.all(15.0), // Margin around the SnackBar
        padding: const EdgeInsets.symmetric(vertical: 15.0), // Vertical padding
        content: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space between content
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0), // Horizontal padding
                child: Text(
                  contentText, // Display the content text
                  style: const TextStyle(
                      color: letterColor, fontSize: 16), // Text style
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0), // Right padding
              child: SnackBarAction(
                onPressed: _restart, // Restart the game on action
                textColor: letterColor, // Text color for the action
                label: 'Otra palabra', // Label for the action
                backgroundColor:
                    actionBackgroundColor, // Background color for the action
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Resets the game state for a new round
  void _restart() {
    setState(() {
      _gameStatus = GameStatus.playing; // Reset game status to playing
      currentWordIndex = 0; // Reset the current word index
      _keyboardLetters.clear(); // Clear the keyboard letters
      _solution = _generateSolution(); // Generate a new solution

      // Reinitialize the game board with empty words
      board = List.generate(
        numGuesses,
        (_) => Word(letters: List.generate(numLetters, (_) => Letter.empty())),
      );

      // Reinitialize keys for FlipCard widgets
      flipCardKeys = List.generate(
        numGuesses,
        (_) => List.generate(numLetters, (_) => GlobalKey<FlipCardState>()),
      );
    });
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildBody()); // Build the main scaffold with the game body
  }

  // Builds the main body of the game screen
  Column _buildBody() {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Space between board and keyboard
      children: [
        Board(words: board, flipCards: flipCardKeys), // Display the game board
        Padding(
          padding:
              const EdgeInsets.only(bottom: 20.0), // Set the desired margin
          child: Keyboard(
            onKeyTapped: _onKeyTapped, // Callback for key taps
            onDeleteTapped: _onDeleteTapped, // Callback for delete key
            onEnterTapped: _onEnterTapped, // Callback for enter key
            letters: _keyboardLetters, // Pass the keyboard letters
          ),
        ),
      ],
    );
  }
}
