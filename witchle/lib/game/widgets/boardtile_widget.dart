// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:witchle/game/witchle.dart';

class BoardTile extends StatelessWidget {
  const BoardTile({
    super.key,
    required this.letter
    });

    final Letter letter;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        height: 48,
        width: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: letter.bgColor,
            border: Border.all(color: letter.borderColor),
            borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
            letter.val,
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
            )
        )
    );
  }
}