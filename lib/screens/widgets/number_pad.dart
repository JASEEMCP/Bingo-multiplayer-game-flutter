import 'package:bingo/screens/game_play_screen.dart';
import 'package:bingo/screens/initial_page.dart';
import 'package:bingo/components/numbers.dart';
import 'package:bingo/value/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Numbers> validDigit =
    List<Numbers>.generate(25, (index) => Numbers(index, isTapped: false));

class NumberPad extends StatelessWidget {
  const NumberPad(
      {super.key,
      required this.indexKey,
      required this.rowLenght,
      required this.onTaped});
  final int indexKey;
  final int rowLenght;
  final Function(int, bool) onTaped;

  @override
  Row build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = indexKey; index <= indexKey + rowLenght; index++)
          index == 26
              ?
              // Submit button
              CupertinoButton(
                  onPressed: () async{
                    if (digitList.contains(-1)) {
                      isFilled.value = true;
                      await Future.delayed(const Duration(seconds: 2));
                      isFilled.value = false;
                      return;
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const ScreenPlayScreen(),
                      ),
                    );
                  },
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width / 4,
                    alignment: Alignment.center,
                    child: const Text(
                      "NEXT",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                )
              :
              //Erase button
              index == 25
                  ? CupertinoButton(
                      onPressed: () {
                        if (digitList[0] == -1) return;
                        currentIndex--;
                        final newIndex = validDigit.indexWhere(
                          (e) => e.index == digitList[currentIndex] - 1,
                        );
                        validDigit[newIndex] =
                            Numbers(newIndex, isTapped: false);
                        onTaped(index, true);
                      },
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                        ),
                        height: 60,
                        width: MediaQuery.of(context).size.width / 7.3,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.backspace,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    )

                  //Number button

                  : CupertinoButton(
                      onPressed: () {
                        if (cacheList.contains(index + 1)) return;

                        validDigit[index] = Numbers(
                          index,
                          isTapped: true,
                        );
                        onTaped(index, false);
                      },
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: validDigit[index].isTapped
                              ? numberPadSelectedColor
                              : numberPadUnSelectedColor,
                        ),
                        height: 60,
                        width: MediaQuery.of(context).size.width / 7.3,
                        alignment: Alignment.center,
                        child: Text(
                          "${index + 1} ",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(204, 7, 7, 7),
                          ),
                        ),
                      ),
                    ),
      ],
    );
  }
}
