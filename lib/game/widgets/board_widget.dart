import 'package:witchle/game/exports.dart';

/// {@template Board}
/// Represents a game board composed of words formed by FlipCards
/// {@endtemplate}
class Board extends StatelessWidget {
  // PROPERTIES ////////////////////////////////////////////////////////////

  final List<Word> words; // List of words

  final List<List<GlobalKey<FlipCardState>>> flipCards; // Objects of import

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer
  const Board({super.key, required this.words, required this.flipCards});

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  // Constructs the widget tree for the board,
  // arranging words in rows and letters in flip cards
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0), // Add margin around the container
      decoration: BoxDecoration(
        color: buttonInitialColor, // Background color for the container
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black, // Shadow color
            blurRadius: 8.0, // Shadow blur radius
            offset: Offset(0, 10), // Shadow offset
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              // Board title
              'Seis letras',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: letterColor,
              ),
            ),
            SizedBox(height: 10), // Spacing box
            ...words
                .asMap() // Index as key of each value in words
                .map(// Iterates in words
                    (i, word) => MapEntry(
                        i,
                        Row(
                          // Makes it a row
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: word.letters
                              .asMap() // Index as key of each value in words
                              .map(// Transforms each letter into a FlipCard
                                  (j, letter) => MapEntry(
                                      j,
                                      FlipCard(
                                        key: flipCards[i][j],
                                        flipOnTouch: false,
                                        direction: FlipDirection.VERTICAL,
                                        front: BoardTile(
                                            letter: Letter(
                                          value: letter.value,
                                          status: LetterStatus.initial,
                                        )),
                                        back: BoardTile(letter: letter),
                                      )))
                              .values
                              .toList(),
                        )))
                .values,
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
