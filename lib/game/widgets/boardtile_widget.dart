import 'package:witchle/game/exports.dart';

/// {@template BoardTile}
/// Represents a game board tile with specific styling and background color
/// determined by the Letter object passed to it
/// {@endtemplate}
class BoardTile extends StatelessWidget {
  // PROPERTIES ////////////////////////////////////////////////////////////

  // The letter object that contains the value and styling information
  final Letter letter;

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer for the BoardTile class
  const BoardTile({super.key, required this.letter});

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  // Builds the widget tree for the BoardTile
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4), // Adds margin around the tile
      height: 55, // Sets the height of the tile
      width: 55, // Sets the width of the tile
      alignment: Alignment.center, // Centers the content within the tile
      decoration: BoxDecoration(
        // Sets the background color based on the letter's status
        color: letter.backgroundColor,
        // Sets the border color based on the letter's status
        border: Border.all(color: letter.borderColor),
        // Applies rounded corners to the tile
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        letter.value, // Displays the letter's value
        style: const TextStyle(
          fontSize: 32, // Sets the font size of the text
          fontWeight: FontWeight.bold, // Sets the font weight to bold
          color: letterColor, // Sets the text color
        ),
      ),
    );
  }
}
