import 'package:witchle/game/exports.dart'; // Importing necessary packages

// Define a stateful widget called TutorialScreen
class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

// Define the state for the TutorialScreen widget
class _TutorialScreenState extends State<TutorialScreen> {
  // PROPERTIES ////////////////////////////////////////////////////////////
  // Define sentences to describe the status of letters in the game
  String sentence1 =
          "La letra 'B' está en la palabra y en la posición correcta.",
      sentence2 =
          "La letra 'R' está en la palabra pero en la posición incorrecta.",
      sentence3 = "La letra 'A' no está en la palabra.";

  // METHODS ////////////////////////////////////////////////////////////////
  // Method to create a board example with tiles and a descriptive sentence
  Widget _boardExample(
      String word, LetterStatus status, int position, String sentence) {
    // Generate a list of BoardTile widgets for each letter in the word
    List<Widget> tiles = List<Widget>.generate(word.length, (index) {
      String value = word[index]; // Get the letter at the current index
      Letter letter;

      // Set the letter's status based on its position
      if (index == position) {
        letter = Letter(value: value, status: status);
      } else {
        letter = Letter(value: value, status: LetterStatus.initial);
      }

      // Return a BoardTile widget for the letter
      return BoardTile(letter: letter);
    });

    // Return a Column widget containing the row of tiles and the sentence
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Row to display the tiles horizontally
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: tiles,
        ),
        SizedBox(height: 10), // Space between tiles and text
        // Text widget to display the descriptive sentence
        Text(
          sentence,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            letterSpacing: 1,
            color: letterColor,
          ),
        ),
      ],
    );
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // Build method to construct the UI of the screen
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title text for the tutorial
            Text(
              'Tutorial',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: letterColor,
              ),
            ),
            SizedBox(height: 30), // Space between title and first example
            // First board example with tiles and text
            _boardExample('BRUJAS', LetterStatus.correct, 0, sentence1),
            SizedBox(height: 30), // Space between examples
            // Second board example with tiles and text
            _boardExample('RITUAL', LetterStatus.inWord, 1, sentence2),
            SizedBox(height: 30), // Space between examples
            // Third board example with tiles and text
            _boardExample('DIABLO', LetterStatus.notInWord, 2, sentence3),
          ],
        ),
      ),
    );
  }
}
