import 'package:bingo/components/numbers.dart';
import 'package:bingo/components/strick_digits.dart';
import 'package:bingo/screens/game_play_screen.dart';
import 'package:bingo/screens/initial_page.dart';
import 'package:bingo/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_menu_tile_widget.dart';
import 'number_pad.dart';

Future showMainMenu(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (
      BuildContext context,
    ) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Column(
          children: [
            const Text(
              "Main menu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            MainMenuTileWidget(
              iconColor: const Color.fromARGB(255, 122, 214, 125),
              icon: CupertinoIcons.play_fill,
              title: "Resume",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MainMenuTileWidget(
              iconColor: const Color.fromARGB(255, 95, 113, 212),
              icon: CupertinoIcons.restart,
              title: "Restart",
              onPressed: () {
                strickDigit = List.generate(
                  25,
                  (index) => StrickDigit(
                    isStrick: false,
                    isSelected: false,
                    column: -1,
                    row: -1,
                  ),
                );

                finishList =
                    List.generate(12, (index) => Bingo(isFinished: false));

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => const InitalPage()));
              },
            ),
            MainMenuTileWidget(
              iconColor: const Color.fromARGB(255, 245, 158, 132),
              icon: Icons.info,
              title: "Exit",
              onPressed: () {
                digitList = List.generate(25, (index) => -1);
                strickDigit = List.generate(
                  25,
                  (index) => StrickDigit(
                    isStrick: false,
                    isSelected: false,
                    column: -1,
                    row: -1,
                  ),
                );

                finishList =
                    List.generate(12, (index) => Bingo(isFinished: false));

                validDigit = List<Numbers>.generate(
                    25, (index) => Numbers(index, isTapped: false));

                cacheList = [];
                currentIndex = 0;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => const MainScreen()));
              },
            ),
          ],
        ),
      );
    },
  );
}
