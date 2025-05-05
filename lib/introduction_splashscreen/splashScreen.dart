import 'package:flutter/material.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/util/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/splachScreen.png",
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 90, right: 66),
            child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  textAlign: TextAlign.center,
                  "WELCOME TO \nMonumental \nhabits",
                  style: TextStyle(
                    fontFamily: "Klasik",
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Color(darkPurple),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
