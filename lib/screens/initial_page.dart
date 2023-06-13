import 'package:bingo/screens/widgets/number_pad.dart';
import 'package:bingo/value/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int currentIndex = 0;
List digitList = List.generate(25, (index) => -1);
List cacheList = [];
ValueNotifier<bool> isFilled = ValueNotifier(false);
class InitalPage extends StatefulWidget {
  const InitalPage({super.key});

  @override
  State<InitalPage> createState() => _InitalPageState();
}

class _InitalPageState extends State<InitalPage> {
  void keyPressed(int index, bool removeDigit) {
    if (cacheList.length < 26) {
      if (removeDigit) {
        digitList[currentIndex] = -1;
        cacheList.removeAt(currentIndex);
      } else {
        cacheList.add(index + 1);
        cacheList.toSet().toList();
        digitList[currentIndex] = index + 1;
        currentIndex++;
      }
    }
    setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        centerTitle: true,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Color.fromARGB(255, 68, 67, 67),
            size: 30,
          ),
        ),
        title: const Text(
          "Enter Random Numbers !",
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(
              255,
              29,
              89,
              138,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.2,
              padding: const EdgeInsets.only(left: 45, right: 45, top: 35),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 25,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: digitList[index] == -1
                        ? const Text("")
                        : Text(
                            "${digitList[index]}",
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 106, 5, 126)),
                          ),
                  );
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: isFilled,
              builder: (context,isFilled,ctx) {
                
                return Visibility(
                  
                  visible: isFilled,
                  child: const Center(
                    child: Text(
                      "Fill the board, then continue",
                      style: TextStyle(
                          color: Color.fromARGB(255, 161, 28, 18),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              }
            ),
            //Number pad

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NumberPad(
                  indexKey: 0,
                  rowLenght: 6,
                  onTaped: keyPressed,
                ),
                NumberPad(
                  indexKey: 7,
                  rowLenght: 6,
                  onTaped: keyPressed,
                ),
                NumberPad(
                  indexKey: 14,
                  rowLenght: 6,
                  onTaped: keyPressed,
                ),
                NumberPad(
                  indexKey: 21,
                  rowLenght: 5,
                  onTaped: keyPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
