import 'package:witchle/game/exports.dart';

/// {@template BoardTile}
/// Represents a game board tile with specific styling and background color
/// determined by the Letter object passed to it
/// {@endtemplate}
class BoardTile extends StatelessWidget {
  // PROPERTIES ////////////////////////////////////////////////////////////
  final Letter letter;

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer
  const BoardTile({super.key, required this.letter});

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  // Creates a square tile with a specific background color, border,
  // and displays a letter in the center
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        height: 55,
        width: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: letter.backgroundColor,
          border: Border.all(color: letter.borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(letter.value,
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: letterColor)));
  }
}
