import 'package:witchle/game/exports.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  // METHODS ////////////////////////////////////////////////////////////////
  List<Widget> BoardExample(String word, LetterStatus status, int position) {
    return List<Widget>.generate(word.length, (index) {
      Color backgroundColor;
      if (index == position) {
        // Set the background color based on the status
        switch (status) {
          case LetterStatus.correct:
            backgroundColor = correctColor;
            break;
          case LetterStatus.inWord:
            backgroundColor = inWordColor;
            break;
          case LetterStatus.notInWord:
            backgroundColor = incorrectColor;
            break;
          default:
            backgroundColor = buttonInitialColor;
        }
      } else {
        backgroundColor = Colors.transparent;
      }

      return Container(
          margin: const EdgeInsets.all(4),
          height: 59,
          width: 59,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(word[index],
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: letterColor)));
    });
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tutorial',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: letterColor,
              ),
            ),
            SizedBox(height: 30),
            // Example board tiles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: BoardExample('BRUJAS', LetterStatus.correct, 0),
            ),
            SizedBox(height: 10),
            Text(
              "La letra 'B' está en la palabra y en la posición correcta.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                letterSpacing: 1,
                color: letterColor,
              ),
            ),
            SizedBox(height: 30),
            // Example board tiles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: BoardExample('RITUAL', LetterStatus.inWord, 1),
            ),
            SizedBox(height: 10),
            Text(
              "La letra 'R' está en la palabra pero en la posición incorrecta.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                letterSpacing: 1,
                color: letterColor,
              ),
            ),
            SizedBox(height: 30),
            //Example board tiles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: BoardExample('DIABLO', LetterStatus.notInWord, 2),
            ),
            SizedBox(height: 10),
            Text(
              "La letra 'A' no está en la palabra.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                letterSpacing: 1,
                color: letterColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
