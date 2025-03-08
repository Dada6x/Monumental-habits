import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool verified = false;
  String buttonText = "Resend Code";
  bool reSendPressed = false;
  int time = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
              color: const Color.fromRGBO(87, 51, 83, 0.1),
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(darkPurple),
                size: 30,
              )),
        ),
        body: Stack(
          children: [
            SvgPicture.asset(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              "assets/images/BackgroundClouds.svg",
              fit: BoxFit.cover,
            ),
            verified
                ? NewPassword()
                : Center(
                    child: Column(children: [
                      Image.asset("assets/images/mail.png"),
                      const Text(
                        "Enter The 6 Digit Code ",
                        style: header,
                      ),
                      const Text(
                        "Sent Via EmailS :",
                        style: header,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: VerificationCode(
                            fillColor: const Color(orange),
                            textStyle: header,
                            underlineWidth: 3,
                            cursorColor: const Color(orange),
                            digitsOnly: true,
                            autofocus: true,
                            underlineColor: const Color(darkPurple),
                            underlineUnfocusedColor: const Color(orange),
                            fullBorder: true,
                            length: 6,
                            onCompleted: (String value) {},
                            onEditing: (value) {}),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(SizeConfig.screenWidth * 0.8, 42),
                          backgroundColor: const Color(orange),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          verified = true;
                          setState(() {});
                        },
                        child: const Text(
                          "Enter",
                          style: klasik,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          reSendPressed = true;
                          Timer.periodic(const Duration(seconds: 1), (timer) {
                            if (time > 0) {
                              time--;
                              buttonText = "Resend Again After $time Seconds.";
                              setState(() {});
                            }
                            if (time == 0) {
                              reSendPressed = false;
                              buttonText = "Resend Code";
                              timer.cancel();
                              time = 5;
                            }
                          });
                        },
                        child: Text(
                          buttonText,
                          style: klasik,
                        ),
                      )
                    ]),
                  ),
          ],
        ));
  }
}

class NewPassword extends StatelessWidget {
  NewPassword({super.key});
  bool ispassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("assets/images/keys.png"),
          const Text(
            "Enter New Password : ",
            style: header,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05, vertical: 8),
            child: TextFormField(
              obscureText: ispassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: const Color(orange),
                  onPressed: () {
                    ispassword = !ispassword;
                  },
                  icon: ispassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                fillColor: const Color(lightorange),
                filled: true,
                prefixIcon: const Icon(Icons.key, color: Color(orange)),
                labelText: "New Password",
                labelStyle: klasik,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(orange)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05, vertical: 8),
            child: TextFormField(
              obscureText: ispassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: const Color(orange),
                  onPressed: () {
                    ispassword = !ispassword;
                  },
                  icon: ispassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                fillColor: const Color(lightorange),
                filled: true,
                prefixIcon: const Icon(Icons.key, color: Color(orange)),
                labelText: "Confirm New Password",
                labelStyle: klasik,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(orange)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(SizeConfig.screenWidth * 0.8, 42),
              backgroundColor: const Color(orange),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Enter",
              style: klasik,
            ),
          )
        ]),
      ),
    );
  }
}
