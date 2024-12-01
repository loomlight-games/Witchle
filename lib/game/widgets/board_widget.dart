import 'package:witchle/game/exports.dart'; // Import necessary dependencies from the 'witchle' package

/// {@template Board}
/// Represents a game board composed of words formed by FlipCards
/// {@endtemplate}
class Board extends StatelessWidget {
  // PROPERTIES ////////////////////////////////////////////////////////////

  final List<Word> words; // List of words to be displayed on the board
  final List<List<GlobalKey<FlipCardState>>>
      flipCards; // Keys for managing the state of FlipCards

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer for the Board class
  const Board({super.key, required this.words, required this.flipCards});

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // Access the singleton instance of SettingsManager
    final SettingsManager settings = SettingsManager();

    // Determine the title based on the number of selected letters
    final String title =
        settings.selectedLetters == 5 ? 'Cinco letras' : 'Seis letras';

    return Container(
      margin: const EdgeInsets.all(10.0), // Add margin around the container
      decoration: BoxDecoration(
        color: buttonInitialColor, // Set the background color for the container
        borderRadius: BorderRadius.circular(12.0), // Apply rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black, // Set shadow color
            blurRadius: 8.0, // Define shadow blur radius
            offset: Offset(0, 1), // Set shadow offset
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(12.0), // Clip the child with rounded corners
        child: Column(
          children: [
            const SizedBox(height: 10), // Add vertical spacing
            Text(
              title, // Display the dynamic title based on settings
              style: const TextStyle(
                fontSize: 30, // Set font size
                fontWeight: FontWeight.bold, // Set font weight to bold
                letterSpacing: 2, // Set letter spacing
                color: letterColor, // Set text color
              ),
            ),
            const SizedBox(height: 10), // Add vertical spacing
            ...words
                .asMap() // Convert the list of words to a map to access indices
                .map((i, word) => MapEntry(
                    i,
                    Row(
                      // Create a row for each word
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center the row's children
                      children: word.letters
                          .asMap() // Convert the list of letters to a map to access indices
                          .map((j, letter) => MapEntry(
                              j,
                              FlipCard(
                                key: flipCards[i][
                                    j], // Use the corresponding key for the FlipCard
                                flipOnTouch: false, // Disable touch flipping
                                direction: FlipDirection
                                    .VERTICAL, // Set flip direction to vertical
                                front: BoardTile(
                                    letter: Letter(
                                  value: letter.value, // Set the letter value
                                  status: LetterStatus
                                      .initial, // Set the initial status
                                )),
                                back: BoardTile(
                                    letter:
                                        letter), // Set the back of the FlipCard
                              )))
                          .values
                          .toList(), // Convert map values to a list
                    )))
                .values, // Convert map values to an iterable
            const SizedBox(height: 6), // Add vertical spacing
          ],
        ),
      ),
    );
  }
}
