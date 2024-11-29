import 'package:witchle/game/witchle.dart';

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
  List<Object?> get props =>
      [letters]; // List of properties needed to check Equatable

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer
  const Word({required this.letters});
  // Factory constructor for word from a string
  // by converting each character into a Letter.
  factory Word.fromString(String word) =>
      // Separates letters and makes a Letter object out of each one
      Word(letters: word.split('').map((e) => Letter(value: e)).toList());

  // METHODS ////////////////////////////////////////////////////////////////

  // Writes in the next letter
  void addLetter(String val) {
    // First empty index
    final currentIndex = letters.indexWhere((e) => e.value.isEmpty);

    if (currentIndex != -1) {
      letters[currentIndex] = Letter(value: val);
    }
  }

  // Empties the last letter
  void removeLetter() {
    //FIXME: NOT WORKING
    // Last filled index
    final recentLetterIndex = letters.lastIndexWhere((e) => e.value.isNotEmpty);

    if (recentLetterIndex != -1) {
      letters[recentLetterIndex] = Letter.empty();
    }
  }
}
