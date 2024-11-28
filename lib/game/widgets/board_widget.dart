import 'package:witchle/game/witchle.dart';

/// {@template Board}
/// Represents a game board composed of words formed by FlipCards
/// {@endtemplate}
class Board extends StatelessWidget {
  // PROPERTIES ////////////////////////////////////////////////////////////

  final List<Word> words; // List of words

  final List<List<GlobalKey<FlipCardState>>> flipCards; // Objects of import 

  // CONSTRUCTORS ///////////////////////////////////////////////////////////
  
  // Initializer
  const Board({
    super.key,
    required this.words,
    required this.flipCards
    });

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  // Constructs the widget tree for the board,
  // arranging words in rows and letters in flip cards
  Widget build(BuildContext context) {
    return Column(
      children: words
        .asMap() // Index as key of each value in words
        .map( // Iterates in words
          (i, word) => MapEntry(
            i, 
            Row( // Makes it a row
              mainAxisAlignment: MainAxisAlignment.center,
              children: word.letters
                .asMap() // Index as key of each value in words
                .map( // Transforms each letter into a FlipCard
                  (j, letter) => MapEntry(j, 
                    FlipCard(
                      key: flipCards[i][j],
                      flipOnTouch: false,
                      direction: FlipDirection.VERTICAL,
                      front: BoardTile(
                        letter: Letter(
                          value: letter.value,
                          status: LetterStatus.initial,
                        )
                      ),
                      back: BoardTile(letter: letter),
                    )
                  )
                )
                .values
                .toList(),
          )
        )
        )
        .values
        .toList(),
    );
  }
}