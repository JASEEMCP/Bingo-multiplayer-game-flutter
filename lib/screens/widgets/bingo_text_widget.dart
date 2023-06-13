import 'package:bingo/screens/game_play_screen.dart';
import 'package:flutter/material.dart';

class BingoTextWidget extends StatelessWidget {
  const BingoTextWidget({
    super.key,
    required this.bingoText,
  });

  final String bingoText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 5; i++)
          Container(
            margin: const EdgeInsets.only(top: 30, left: 1),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: finishList[i].isFinished
                  ? const Color.fromARGB(255, 14, 112, 96)
                  : const Color.fromARGB(255, 255, 255, 255),
            ),
            height: 50,
            width: 50,
            child: Text(
              bingoText[i],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: finishList[i].isFinished
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : const Color.fromARGB(255, 12, 94, 94),
              ),
            ),
          )
      ],
    );
  }
}
