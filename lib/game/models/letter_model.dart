import 'package:witchle/game/exports.dart';

// Status of letter
enum LetterStatus { initial, notInWord, inWord, correct }

/// {@template Letter}
/// Letter with a state and colors according to it
/// {@endtemplate}
class Letter extends Equatable {
  // Equatable: A base class to facilitate [operator ==] and [hashCode] overrides

  // PROPERTIES ////////////////////////////////////////////////////////////

  final String value; // The letter itself
  final LetterStatus status; // The status of the letter

  // Get background color based on the letter's status
  Color get backgroundColor {
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

  // Get border color based on the letter's status
  Color get borderColor {
    return status == LetterStatus.initial
        ? currentBorderColor
        : Colors.transparent;
  }

  @override
  List<Object> get props => [value, status]; // Properties for Equatable

  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Constructor to initialize a Letter
  const Letter({
    required this.value, // Must specify the letter value
    this.status = LetterStatus.initial, // Default status is initial
  });

  // Factory constructor for an empty letter
  factory Letter.empty() => const Letter(value: '');

  // METHODS ////////////////////////////////////////////////////////////////

  /// Create a copy of the Letter with updated values
  Letter copyWith({
    String? val,
    LetterStatus? status,
  }) {
    return Letter(
      value: val ?? value, // Use existing value if not provided
      status: status ?? this.status, // Use existing status if not provided
    );
  }
}
