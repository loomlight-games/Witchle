import 'package:witchle/game/witchle.dart';

// Content of keyboard
const _qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ñ'],
  ['PROBAR','Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BORRAR']
];

/// {@template Keyboard}
/// Represents a custom keyboard layout of column of rows to display keys
/// stylied by its letter
/// {@endtemplate}
class Keyboard extends StatelessWidget {
  // PROPERTIES ////////////////////////////////////////////////////////////
  final Set<Letter> letters; // Keys
  final void Function(String) onKeyTapped; // Key callback
  final VoidCallback onDeleteTapped; // Delete key callback
  final VoidCallback onEnterTapped; // Enter key callback

  // CONSTRUCTORS ///////////////////////////////////////////////////////////
  
  // Initializer
  const Keyboard({
    super.key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.letters,
  });

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  // Arranges keys in rows and handling special keys for delete and enter
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _qwerty // Content of keyboard
        .map( // Iterates in _qwerty
          (keyRow) => Row( // Each line is a row
            mainAxisAlignment: MainAxisAlignment.center,
            children: keyRow
            .map( // Iterates in the row
              (letter) { // Each letter
                if (letter == 'BORRAR'){ 
                  // Delete callback
                  return _KeyboardButton.delete(onTap: onDeleteTapped);
                } else if (letter == 'PROBAR'){ // Todo: enable only when word is filled
                  // Enter call back
                  return _KeyboardButton.enter(onTap: onEnterTapped);
                } else { 
                  final letterKey = letters.firstWhere(
                    (e) => e.value == letter,
                    orElse: () => Letter.empty(),
                  );

                  return _KeyboardButton(
                    // Normal key callback
                    onTap: () => onKeyTapped(letter),
                    letter: letter,
                    backGroundColor: letterKey != Letter.empty()?
                      letterKey.backgroundColor : buttonInitialColor 
                  );
                }
              }
            ).toList(),
          ),
        ).toList(),
    );
  }
}

/// {@template _KeyboardButton}
/// Represents a button in the keyboard layout
/// Private class bc is only used in this file
/// {@endtemplate}
class _KeyboardButton extends StatelessWidget {
  // PROPERTIES ////////////////////////////////////////////////////////////
  final double height, width;
  final VoidCallback onTap;
  final Color backGroundColor;
  final String letter;

  // CONSTRUCTORS ///////////////////////////////////////////////////////////
  
  // Initializer
  const _KeyboardButton({
    this.height = 45, // TODO: make this a variable
    this.width = 35, // TODO: make this a variable
    required this.onTap,
    required this.backGroundColor,
    required this.letter,
  });

  // Factory constructor for delete button
  factory _KeyboardButton.delete({ //! NOT WORKING bc is not implemented
    required VoidCallback onTap,
  }) =>
    _KeyboardButton(
      width: 56, // TODO: make this a variable
      onTap: onTap,
      backGroundColor: specialButtonColor,
      letter: 'BORRAR',
  );

  // Factory constructor for enter button
  factory _KeyboardButton.enter({
    required VoidCallback onTap,
  }) =>
    _KeyboardButton(
      width: 56, // TODO: make this a variable
      onTap: onTap,
      backGroundColor: specialButtonColor,
      letter: 'PROBAR',
  );

  // WIDGET /////////////////////////////////////////////////////////////////
  // Represents a button with a specific style and behavior. It uses Flutter's 
  // Material and InkWell widgets to provide a visual and interactive button experience
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 2,
      ),
      child: Material(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(4),
        child: InkWell( // Handles tap interactions with a bloom effect
          onTap: onTap, // Callback function triggered when the button is tapped.
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 12, // TODO: make this a variable and differenciate for special keys
                fontWeight: FontWeight.w600,
              )
            )
          ),
        )
      )
    );
  }
}