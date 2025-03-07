import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

Widget Button(String text, Function fun) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(SizeConfig.screenWidth, 42),
      backgroundColor: const Color(orange),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    onPressed: () {
      fun();
    },
    child: Text(
      text,
      style: manrope,
    ),
  );
}

Widget GoogleButton() {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(SizeConfig.screenWidth, 41),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            //! no need for the padding but the svg image is trash
            padding: const EdgeInsets.only(top: 5, right: 5),
            child: SvgPicture.asset(
              "assets/images/Google.svg",
              height: 35,
              width: 35,
            ),
          ),
          const Text(
            "Continue with Google",
            style: manrope,
          ),
        ],
      ));
}

Widget FaceBookButton() {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(SizeConfig.screenWidth, 41),
        backgroundColor: const Color(0xFF209BE3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(AntDesign.facebook_square),
          Text(
            "Continue with Google",
            style: manrope,
          ),
        ],
      ));
}
