import 'package:witchle/game/exports.dart';

// Define the keyboard layout as a constant
const _qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ñ'],
  ['PROBAR', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BORRAR']
];

class Keyboard extends StatelessWidget {
  // PROPERTIES ////////////////////////////////////////////////////////////

  final Set<Letter> letters; // Set of letters with their statuses
  final void Function(String) onKeyTapped; // Callback for key taps
  final VoidCallback onDeleteTapped; // Callback for delete key
  final VoidCallback onEnterTapped; // Callback for enter key

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer for the Keyboard class
  const Keyboard({
    super.key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.letters,
  });

  // METHODS ////////////////////////////////////////////////////////////////
  /// Helper method to build a row of keys
  Widget _buildKeyRow(List<String> keyRow) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Center the keys horizontally
      children: keyRow.map((letter) => _buildKey(letter)).toList(),
    );
  }

  /// Helper method to build individual keys
  Widget _buildKey(String letter) {
    if (letter == 'BORRAR') {
      return _KeyboardButton.delete(onTap: onDeleteTapped);
    } else if (letter == 'PROBAR') {
      return _KeyboardButton.enter(onTap: onEnterTapped);
    } else {
      final letterKey = letters.firstWhere(
        (e) => e.value == letter,
        orElse: () => Letter.empty(),
      );

      return _KeyboardButton(
        onTap: () => onKeyTapped(letter),
        letter: letter,
        backGroundColor: letterKey != Letter.empty()
            ? letterKey.backgroundColor
            : buttonInitialColor,
      );
    }
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Center the keyboard vertically
      children: _qwerty.map((keyRow) => _buildKeyRow(keyRow)).toList(),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  // PROPERTIES ////////////////////////////////////////////////////////////

  final double height = 45; // Fixed height for all buttons
  final double width; // Width can vary
  final VoidCallback onTap; // Callback for button tap
  final Color backGroundColor; // Background color of the button
  final String letter; // Letter displayed on the button
  final Icon? icon; // Optional icon for special buttons

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer for the _KeyboardButton class
  const _KeyboardButton({
    this.width = 36, // Default width for regular keys
    required this.onTap,
    required this.backGroundColor,
    required this.letter,
    this.icon,
  });

  // Factory constructor for delete button
  factory _KeyboardButton.delete({
    required VoidCallback onTap,
  }) =>
      _KeyboardButton(
        width: 56, // Wider width for special keys
        onTap: onTap,
        backGroundColor: specialButtonColor,
        letter: '',
        icon: const Icon(Icons.keyboard_backspace, color: letterColor),
      );

  // Factory constructor for enter button
  factory _KeyboardButton.enter({
    required VoidCallback onTap,
  }) =>
      _KeyboardButton(
        width: 56, // Wider width for special keys
        onTap: onTap,
        backGroundColor: specialButtonColor,
        letter: '',
        icon: const Icon(Icons.keyboard_double_arrow_up, color: letterColor),
      );

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 4, horizontal: 2), // Padding around each button
      child: Material(
        color: backGroundColor, // Set the button's background color
        borderRadius:
            BorderRadius.circular(5), // Rounded corners for the button
        child: InkWell(
          onTap: onTap, // Handle tap events
          child: Container(
            height: height, // Set the button's height
            width: width, // Set the button's width
            alignment: Alignment.center, // Center the content within the button
            child: FittedBox(
              child: icon ?? // Display icon if available
                  Text(
                    letter, // Display letter if no icon
                    style: const TextStyle(
                      fontSize: 25, // Font size for the letter
                      fontWeight: FontWeight.w400, // Font weight
                      color: letterColor, // Text color
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
