import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:witchle/app/app_colors.dart';

enum LetterStatus {initial, notInWord, inWord, correct}

class Letter extends Equatable{ // Equatable: A base class to facilitate [operator ==] and [hashCode] overrides
  const Letter({
    required this.val,
    this.status = LetterStatus.initial,
  });

  // Empty constructor
  factory Letter.empty() => const Letter(val:'');

  final String val; // Letter it is
  final LetterStatus status;

  Color get bgColor{
    switch (status){
      case LetterStatus.initial:
        return Colors.transparent;
      case LetterStatus.notInWord:
        return notInWordColor;
      case LetterStatus.inWord:
        return inWordColor;
      case LetterStatus.correct:
        return correctColor;
      default:
        return Colors.transparent;
    }
  }

  Color get borderColor{
    switch (status){
      case LetterStatus.initial:
        return Colors.grey;
      default:
        return Colors.transparent;
    }
  }

  // Creates a new instance of Letter with updated values for val and status, 
  // while retaining the original values if new ones are not provided.
  Letter copyWith({
    String? val,
    LetterStatus? status,
  }){
    return Letter(
      val: val?? this.val,
      status: status?? this.status,
    );
  }

  @override
  // List of properties needed to check Equatable
  List<Object> get props => [val,status];
}