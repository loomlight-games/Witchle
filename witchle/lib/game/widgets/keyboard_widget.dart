import 'package:flutter/material.dart';
import 'package:witchle/game/models/letter_model.dart';

const _qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ñ'],
  ['PROBAR','Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BORRAR']
];

class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.letters,
  });

  final void Function(String) onKeyTapped;

  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;

  final Set<Letter> letters;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _qwerty
        .map(
          (keyRow) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: keyRow.map(
              (letter) {
                if (letter == 'BORRAR'){
                  return _KeyboardButton.delete(onTap: onDeleteTapped);
                } else if (letter == 'PROBAR'){
                  return _KeyboardButton.enter(onTap: onEnterTapped);
                } else {
                  final letterKey = letters.firstWhere(
                    (e) => e.val == letter,
                    orElse: () => Letter.empty(),
                  );

                  return _KeyboardButton(
                    onTap: () => onKeyTapped(letter),
                    letter: letter,
                    backGroundColor: letterKey != Letter.empty()?
                      letterKey.bgColor : Colors.grey
                  );
                }
              }
            ).toList(),
          ),
        ).toList(),
    );
  }
}

// Private class bc is only used in this file
class _KeyboardButton extends StatelessWidget {
  // Properties
  final double height, width;
  final VoidCallback onTap;
  final Color backGroundColor;
  final String letter;

  // Constructor
  const _KeyboardButton({
    super.key,
    this.height = 48,
    this.width = 30,
    required this.onTap,
    required this.backGroundColor,
    required this.letter,
  });

  // Delete button constructor
  factory _KeyboardButton.delete({
    required VoidCallback onTap,
  }) =>
    _KeyboardButton(
      width: 56,
      onTap: onTap,
      backGroundColor: Colors.grey,
      letter: 'BORRAR',
  );

    // Enter button constructor
  factory _KeyboardButton.enter({
    required VoidCallback onTap,
  }) =>
    _KeyboardButton(
      width: 56,
      onTap: onTap,
      backGroundColor: Colors.grey,
      letter: 'PROBAR',
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 2,
      ),
      child: Material(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(4),
        child: InkWell( // Bloom effect when pressing button
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )
            )
          ),
        )
      )
    );
  }
}