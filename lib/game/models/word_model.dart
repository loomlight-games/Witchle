import 'package:witchle/game/exports.dart';

/// {@template Word}
/// Word with a list of [Letters] transformable to String
/// {@endtemplate}
class Word extends Equatable {
  // PROPERTIES ////////////////////////////////////////////////////////////

  final List<Letter> letters;

  // String representation of the word
  String get wordString => letters.map((letter) => letter.value).join();

  @override
  // List of properties needed to check Equatable
  List<Object?> get props => [letters];

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer
  const Word({required this.letters});

  // Factory constructor for word from a string
  // by converting each character into a Letter.
  factory Word.fromString(String word) => Word(
      letters: word.split('').map((letter) => Letter(value: letter)).toList());

  // METHODS ////////////////////////////////////////////////////////////////

  /// Writes in the next letter
  void addLetter(String val) {
    // Find the first empty index
    final currentIndex = letters.indexWhere((letter) => letter.value.isEmpty);

    // If an empty index is found, replace it with the new letter
    if (currentIndex != -1) {
      letters[currentIndex] = Letter(value: val);
    }
  }

  /// Empties the last letter
  void removeLetter() {
    // Find the last filled index
    final recentLetterIndex =
        letters.lastIndexWhere((letter) => letter.value.isNotEmpty);

    // If a filled index is found, replace it with an empty letter
    if (recentLetterIndex != -1) {
      letters[recentLetterIndex] = Letter.empty();
    }
  }
}
