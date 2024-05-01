import 'package:bingo/components/strick_digits.dart';
import 'package:bingo/screens/initial_page.dart';
import 'package:bingo/screens/widgets/alert_main_menu.dart';
import 'package:bingo/value/colors.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import 'widgets/bingo_text_widget.dart';

List<StrickDigit> strickDigit = List.generate(
    25,
    (index) =>
        StrickDigit(isStrick: false, isSelected: false, column: -1, row: -1));

List<Bingo> finishList = List.generate(12, (index) => Bingo(isFinished: false));

class ScreenPlayScreen extends StatefulWidget {
  const ScreenPlayScreen({
    super.key,
  });

  @override
  State<ScreenPlayScreen> createState() => _ScreenPlayScreenState();
}

class _ScreenPlayScreenState extends State<ScreenPlayScreen> {
  final String bingoText = "BINGO";
  List<List> digit2D = List.generate(5, (index1) {
    int breakIndex = index1 * 5;
    return List.generate(5, (index) {
      index += breakIndex;
      return digitList[index];
    });
  });

  List<int> maxStrickCount = List.generate(12, (index) => 0);

  int finishCount = 0;
  int numberOfDigitsLeft = 0;
  int curruntIndex = -1;
  AudioPlayer buttonPressedAudioPlayer = AudioPlayer();
  String audioasset = "assets/audio/click-button-140881.mp3";
  void boxPressed(int row, int column, int index) async {
    buttonPressedAudioPlayer.play();
    //Change Bingo board propertiesplayBytes(bytedata);
    strickDigit[index] = StrickDigit(
        isSelected: true, column: column, row: row, isStrick: false);
    curruntIndex += 1;
    //Board Strick count List Vertical, Horizontal and Diagonal
    if (column != row) {
      maxStrickCount[row] += 1;
      maxStrickCount[column + 5] += 1;
      if ((row + column) == 4) {
        maxStrickCount[11] += 1;
      }
    } else {
      maxStrickCount[row] += 1;
      maxStrickCount[column + 5] += 1;
      maxStrickCount[10] += 1;
      if (row == 2) {
        maxStrickCount[11] += 1;
      }
    }
    //Count of Number of Digits Left
    numberOfDigitsLeft =
        strickDigit.where((element) => element.isSelected == true).length;

    //Count the Number of Strick Occured
    finishCount = maxStrickCount.where((element) => element == 5).length;
    for (int i = 0; i < 12; i++) {
      if (maxStrickCount[i] == 5) {
        if (!finishList[i].isFinished) {
          if (finishCount >= 5) {
            finishCount = 5;
          }
          //Perfome isFinshed is true
          for (int k = 0; k < finishCount; k++) {
            finishList[k] = Bingo(isFinished: true);
          }
        }
        //Get the index from set of horizontal,
        // vertical and diagonal list
        for (int j = 0; j < 5; j++) {
          int newIndex = strickPattern[i][j];
          strickDigit[newIndex] = StrickDigit(
              isSelected: true, column: column, row: row, isStrick: true);
        }
      }
    }

    setState(() {});

    await buttonPressedAudioPlayer.setAsset(audioasset);
  }

  late ConfettiController controllerTopCenter;
  late Uint8List audiobytes;
  void initializeSFX() async {
    await buttonPressedAudioPlayer.setAsset(audioasset);
  }

  void initController() {
    controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void initState() {
    initController();
    initializeSFX();
    super.initState();
  }

  bool isWon = false;

  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding().addPostFrameCallback((timeStamp) {
    //   //initController();
    // });
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,

          // Main menu button

          leading: IconButton(
            splashRadius: 20,
            onPressed: () async {
              await showMainMenu(context);
            },
            icon: const Icon(
              CupertinoIcons.pause_solid,
              size: 35,
              color: Color.fromARGB(255, 6, 105, 129),
            ),
          ),
        ),
        backgroundColor: scaffoldBackroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Bingo Text Section
                  BingoTextWidget(bingoText: bingoText),

                  //Bingo Board

                  Container(
                    height: MediaQuery.of(context).size.height / 2.3,
                    padding:
                        const EdgeInsets.only(left: 45, right: 45, top: 30),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 25,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemBuilder: (context, index) {
                        final row = index ~/ 5;
                        final col = index % 5;
                        return CupertinoButton(
                          onPressed: () {
                            //Check whether the number is already typed
                            if (finishCount >= 5 && isWon ||
                                strickDigit[index].isSelected) {
                              return;
                            }
                            boxPressed(row, col, index);
                            if (finishCount >= 5 && !isWon) {
                              controllerTopCenter.play();
                              isWon = true;
                            }
                          },
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            alignment: Alignment.center,
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: strickDigit[index].isSelected
                                  ? strickDigit[index].isSelected &&
                                          strickDigit[index].isStrick
                                      ? const Color.fromARGB(255, 149, 221, 142)
                                      : const Color.fromARGB(255, 233, 117, 108)
                                  : boxBackgroundColor,
                            ),
                            child: digit2D[row][col] == -1
                                ? const Text("")
                                : Text(
                                    "${digit2D[row][col]}",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 14, 6, 15),
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),

                  //Number of digit Left text
                  Padding(
                    padding: const EdgeInsets.only(left: 45, top: 10),
                    child: Text(
                      "Number of digits left :  ${25 - numberOfDigitsLeft} ",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 3, 56, 87)),
                    ),
                  ),
                  Visibility(
                    visible: finishCount >= 5,
                    // replacement: Padding(
                    //   padding: const EdgeInsets.only(top: 50.0),
                    //   child: Center(
                    //     child: CircleAvatar(
                    //       backgroundColor:
                    //           const Color.fromARGB(255, 216, 125, 119),
                    //       radius: 30,
                    //       //Step one back button
                    //       child: IconButton(
                    //         onPressed: () {

                    //         },
                    //         icon: const Icon(
                    //           CupertinoIcons.back,
                    //           size: 30,
                    //           color: Color.fromARGB(255, 82, 12, 7),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: Text(
                          "You Won",
                          style: TextStyle(
                              letterSpacing: 4,
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 12, 117, 109)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //Confitt
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  maximumSize: const Size(30, 30),
                  shouldLoop: false,
                  confettiController: controllerTopCenter,
                  blastDirection: 0,
                  blastDirectionality: BlastDirectionality.explosive,
                  maxBlastForce: 20,
                  minBlastForce: 8,
                  emissionFrequency: 1,
                  gravity: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
