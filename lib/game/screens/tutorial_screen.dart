import 'package:witchle/game/exports.dart'; // Import necessary packages for the game

/// {@template TutorialScreen}
/// Define a stateful widget called TutorialScreen
/// {@endtemplate}
class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key}); // Constructor with a key for the widget

  @override
  State<TutorialScreen> createState() =>
      _TutorialScreenState(); // Create the state for this widget
}

/// {@template TutorialScreenState}
/// Define the state for the TutorialScreen widget
/// {@endtemplate}
class _TutorialScreenState extends State<TutorialScreen> {
  // PROPERTIES ////////////////////////////////////////////////////////////

  // Define sentences to describe the status of letters and button actions
  String sentence1 =
          "La letra 'B' está en la palabra y en la posición correcta.",
      sentence2 =
          "La letra 'R' está en la palabra pero en la posición incorrecta.",
      sentence3 = "La letra 'A' no está en la palabra.",
      sentence4 = "Pulsa este botón para borrar la última letra introducida.",
      sentence5 = "Pulsa este botón para comprobar si la palabra es acertada.";

  // Define a TextStyle for normal text to ensure consistency
  static const TextStyle normalTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
    color: letterColor, // Use a predefined color for text
  );

  // METHODS ////////////////////////////////////////////////////////////////
  // Method to create the title widget
  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10), // Add vertical padding
      child: Text(
        title, // Display the title text
        style: TextStyle(
          fontSize: 30, // Use the defined title size
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: letterColor, // Use a predefined color for the title
        ),
        textAlign: TextAlign.center, // Center the text horizontally
      ),
    );
  }

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), // Add vertical padding
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center children vertically
        children: [
          // Row to display the tiles horizontally
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center tiles horizontally
            children: tiles, // Add the generated tiles
          ),
          const SizedBox(height: 10), // Space between tiles and text
          // Container with margins to prevent overflow
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 20), // Horizontal margins
            child: Text(
              sentence, // Display the descriptive sentence
              textAlign: TextAlign.center, // Center the text horizontally
              style: normalTextStyle, // Use the predefined text style
            ),
          ),
        ],
      ),
    );
  }

  // Method to create a button example with an icon and descriptive text
  Widget _buttonExample(String sentence, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), // Add vertical padding
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center children horizontally
        children: [
          // Icon widget with rounded corners and specific margins
          Container(
            decoration: BoxDecoration(
              color:
                  specialButtonColor, // Use a predefined color for the button
              borderRadius: BorderRadius.circular(5), // Rounded corners
            ),
            height: 45, // Set the height of the icon container
            width: 56, // Set the width of the icon container
            margin: const EdgeInsets.only(
                left: 20, right: 10), // Specific margins for the icon
            child: icon, // Display the icon
          ),
          // Flexible Container with right margin to prevent overflow
          Flexible(
            child: Container(
              margin:
                  const EdgeInsets.only(right: 20), // Right margin for the text
              child: Text(
                sentence, // Display the descriptive sentence
                textAlign: TextAlign.center, // Center the text horizontally
                style: normalTextStyle, // Use the predefined text style
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // Build method to construct the UI of the screen
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0), // Add margin around the container
          decoration: BoxDecoration(
            color: buttonInitialColor, // Background color for the container
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 8.0,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                12.0), // Ensure content respects the border radius
            child: SingleChildScrollView(
              // Use SingleChildScrollView to prevent overflow
              child: Column(
                children: [
                  //SizedBox(height: 10),
                  // Title text for the tutorial
                  _buildTitle('Tutorial'),
                  //SizedBox(height: 7),
                  const Text(
                    'Es una palabra de temática embrujada.',
                    textAlign: TextAlign.center, // Center the text horizontally
                    style: normalTextStyle,
                  ),
                  SizedBox(height: 16),
                  // First board example with tiles and text
                  _boardExample('BRUJAS', LetterStatus.correct, 0, sentence1),
                  // Second board example with tiles and text
                  _boardExample('RITUAL', LetterStatus.inWord, 1, sentence2),
                  // Third board example with tiles and text
                  _boardExample('DIABLO', LetterStatus.notInWord, 2, sentence3),
                  SizedBox(height: 22),
                  // Button examples with icons and text
                  _buttonExample(sentence4,
                      const Icon(Icons.keyboard_backspace, color: letterColor)),
                  _buttonExample(
                      sentence5,
                      const Icon(Icons.keyboard_double_arrow_up,
                          color: letterColor)),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
