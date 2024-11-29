import 'package:witchle/game/witchle.dart';

// Status of letter
enum LetterStatus { initial, notInWord, inWord, correct }

/// {@template Letter}
/// Letter with an state and colors according to it
/// {@endtemplate}
class Letter extends Equatable {
  // Equatable: A base class to facilitate [operator ==] and [hashCode] overrides
  // PROPERTIES ////////////////////////////////////////////////////////////

  final String value; // Letter it is

  final LetterStatus status;

  Color get backgroundColor {
    // Color according to status
    switch (status) {
      case LetterStatus.notInWord:
        return incorrectColor;
      case LetterStatus.inWord:
        return inWordColor;
      case LetterStatus.correct:
        return correctColor;
      default:
        return Colors.transparent;
    }
  }

  Color get borderColor {
    // Color according to status
    switch (status) {
      case LetterStatus.initial:
        return currentBorderColor;
      default:
        return Colors.transparent;
    }
  }

  @override
  List<Object> get props =>
      [value, status]; // List of properties needed to check Equatable

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer
  const Letter({
    required this.value, // Must specify
    this.status = LetterStatus.initial,
  });

  // Factory constructor for empty word
  factory Letter.empty() => const Letter(value: '');

  // METHODS ////////////////////////////////////////////////////////////////

  // Modify Letter by a copy - Letter is inmutable
  // Creates a new instance of Letter with updated values for val and status,
  // while retaining the original values if new ones are not provided.
  Letter copyWith({
    String? val,
    LetterStatus? status,
  }) {
    // Returns new letter
    return Letter(
      value: val ?? value, // This value if not given
      status: status ?? this.status, // This status if not given
    );
  }
}
