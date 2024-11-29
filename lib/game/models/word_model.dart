import 'package:witchle/game/exports.dart';

/// {@template Word}
/// Wird with a list of [Letters] transformable to String
/// {@endtemplate}
class Word extends Equatable {
  // PROPERTIES ////////////////////////////////////////////////////////////

  final List<Letter> letters;

  String get wordString => // String representation of the word
      // Joins each Letter value to form a String
      letters.map((e) => e.value).join();

  @override
  // List of properties needed to check Equatable
  List<Object?> get props => [letters];

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer
  const Word({required this.letters});

  // Factory constructor for word from a string
  // by converting each character into a Letter.
  factory Word.fromString(String word) =>
      // Separates letters and makes a Letter object out of each one
      Word(
          letters:
              word.split('').map((letter) => Letter(value: letter)).toList());

  // METHODS ////////////////////////////////////////////////////////////////

  // Writes in the next letter
  void addLetter(String val) {
    // First empty index
    final currentIndex = letters.indexWhere((letter) => letter.value.isEmpty);

    if (currentIndex != -1) {
      letters[currentIndex] = Letter(value: val);
    }
  }

  // Empties the last letter
  void removeLetter() {
    // Last filled index
    final recentLetterIndex =
        letters.lastIndexWhere((letter) => letter.value.isNotEmpty);

    if (recentLetterIndex != -1) {
      letters[recentLetterIndex] = Letter.empty();
    }
  }
}
