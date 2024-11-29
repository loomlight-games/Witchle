import 'package:witchle/game/exports.dart';

// Content of keyboard
const _qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ñ'],
  ['PROBAR', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BORRAR']
];

class Keyboard extends StatelessWidget {
  final Set<Letter> letters;
  final void Function(String) onKeyTapped;
  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;

  const Keyboard({
    super.key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.letters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _qwerty
          .map(
            (keyRow) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: keyRow.map((letter) {
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
              }).toList(),
            ),
          )
          .toList(),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  final double height = 45, width;
  final VoidCallback onTap;
  final Color backGroundColor;
  final String letter;
  final Icon? icon;

  const _KeyboardButton({
    this.width = 36,
    required this.onTap,
    required this.backGroundColor,
    required this.letter,
    this.icon,
  });

  factory _KeyboardButton.delete({
    required VoidCallback onTap,
  }) =>
      _KeyboardButton(
        width: 56,
        onTap: onTap,
        backGroundColor: specialButtonColor,
        letter: '',
        icon: const Icon(Icons.keyboard_backspace, color: letterColor),
      );

  factory _KeyboardButton.enter({
    required VoidCallback onTap,
  }) =>
      _KeyboardButton(
        width: 56,
        onTap: onTap,
        backGroundColor: specialButtonColor,
        letter: '',
        icon: const Icon(Icons.keyboard_double_arrow_up, color: letterColor),
      );

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
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: FittedBox(
              child: icon ??
                  Text(
                    letter,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: letterColor),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
