import 'package:flutter/material.dart';

//! Define the used color
const orange = 0xFFFDA758;
const darkOrange = 0xFFFC9D45;
const creamybackground = 0xFFFEF2E8;
const background = 0xFFFFF3E9;
const lavander = 0xFFAA98A8;
const darkPurple = 0xFF573353;
const lightOrange = 0xFFFFF6ED;
//? Define the images and visuals like this in a folder
const habits = "assets/images/Habits.svg";
const intro1 = "assets/images/intro1.svg";
const intro2 = "assets/images/intro2.svg";
const intro3 = "assets/images/intro3.svg";
const intro4 = "assets/images/intro4.svg";
const signupImg = "assets/images/CreateYourAccount.svg";
const splashScreen = "assets/images/splachScreen.png";
const questionIcon = "assets/images/question.svg";
const backGround = "assets/images/BackgroundClouds.svg";
const forgotPassword = "assets/images/ForgotPassword.svg";
const mailImage = "assets/images/mailImage.svg";
const keysIcons = "assets/images/Keys.svg";
const backGround2 = "assets/images/BackGround2.svg";
//! define an textStyle with the color and the size fixed
// make reusable widgets

//$ ------------------klasik------------------
const TextStyle klasik = TextStyle(
  fontFamily: "Klasik",
  fontSize: 17,
  color: Color(darkPurple),
);
const TextStyle klasikOrange = TextStyle(
  fontFamily: "Klasik",
  fontSize: 17,
  color: Color(darkOrange),
);
const TextStyle klasikHint = TextStyle(
  fontFamily: "Klasik",
  fontSize: 17,
  color: Color(lavander),
);

const TextStyle klasikHeader = TextStyle(
  fontFamily: "Klasik",
  fontSize: 25,
  color: Color(darkPurple),
);
//$ ------------------manrope------------------
const TextStyle manrope = TextStyle(
  fontFamily: "Manrope",
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Color(darkPurple),
);
const TextStyle manropeLavander = TextStyle(
  fontFamily: "Manrope",
  fontSize: 14,
  color: Color(lavander),
);
const TextStyle manropeOrange = TextStyle(
  fontFamily: "Manrope",
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Color(darkOrange),
);

var   containerDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(16),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      blurRadius: 6,
      spreadRadius: 2,
    ),
  ],
);

// THE ORANGE BUTTON
/*
ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 40),
                backgroundColor: const Color(orange),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Get Started ",
                style: TextStyle(color: Color(purple)),
              ),
            ),
*/
