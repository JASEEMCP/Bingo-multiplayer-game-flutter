import 'package:bingo/screens/initial_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/bingo.jpg",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 20),
            child: CupertinoButton(
              color: const Color.fromARGB(255, 80, 78, 109),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const InitalPage(),
                    ));
              },
              child: const Text(
                "Play",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 248, 248, 248),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 30, bottom: 30),
            alignment: Alignment.bottomRight,
            child: IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.exit_to_app,
                size: 30,
                color: Color.fromARGB(255, 138, 16, 16),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
