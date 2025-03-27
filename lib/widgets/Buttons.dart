import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:monumental_habits/util/helper.dart';

Widget Button(BuildContext context, String text, Function fun) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(MediaQuery.of(context).size.width, 42),
      backgroundColor: Get.isDarkMode
          ? const Color.fromRGBO(240, 222, 250, 0.8)
          : const Color(orange),
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

Widget googleButton(BuildContext context) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 41),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        //! GO TO GOOGLE HEHEHE
        //jk login or signup via google
      },
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

Widget faceBookButton(BuildContext context) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 41),
        backgroundColor: const Color.fromARGB(252, 36, 112, 235),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.facebook,
            color: Colors.white,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "Continue with facebook",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ));
}
