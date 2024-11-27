import 'package:equatable/equatable.dart';
import 'package:witchle/game/witchle.dart';

class Word extends Equatable{
  const Word({
    required this.letters
  });

  // Constructor from string
  // Separates letters and makes a Letter object out of each one
  factory Word.fromString(String word) => 
    Word(letters: word.split('').map((e) => Letter(val: e)).toList());

  final List<Letter> letters;

  String get wordString => letters.map((e) => e.val).join();

  // Writes in the last letter
  void addLetter(String val){
    // First empty index
    final currentIndex = letters.indexWhere((e) => e.val.isEmpty);

    if (currentIndex != -1){
      letters[currentIndex] = Letter(val:val);
    }
  }

  // Empties the last letter
  void removeLetter(){
    // Last filled index
    final recentLetterIndex = letters.lastIndexWhere((e) => e.val.isNotEmpty);

    if (recentLetterIndex != -1){
      letters[recentLetterIndex] = Letter.empty();
    }
  }
  
  @override
  // List of properties needed to check Equatable
  List<Object?> get props => [letters];
}