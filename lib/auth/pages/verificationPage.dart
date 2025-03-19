import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';
import 'package:monumental_habits/widgets/Buttons.dart';
import 'package:monumental_habits/widgets/text_fields.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool verified = false;
  String buttonText = "Resend Code";
  int reSendPressed = 0;
  int time = 5;
  @override
  void dispose() {
    super.dispose();
    time = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(background),
        resizeToAvoidBottomInset: true,
        // appBar: AppBar(
        //   leading: IconButton(
        //       color: const Color.fromRGBO(87, 51, 83, 0.1),
        //       onPressed: () {
        //         Get.back();
        //       },
        //       icon: const Icon(
        //         Icons.arrow_back,
        //         color: Color(darkPurple),
        //         size: 30,
        //       )),
        // ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SvgPicture.asset(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                "assets/images/BackgroundClouds.svg",
                fit: BoxFit.cover,
              ),
              verified
                  ? NewPassword()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Row(
                            children: [BackButton()],
                          ),
                          Column(children: [
                            SvgPicture.asset(mailImage),
                            const Text(
                              "Enter The 6 Digit Code ",
                              style: klasikHeader,
                            ),
                            const Text(
                              "Sent Via EmailS :",
                              style: klasikHeader,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 20),
                              child: VerificationCode(
                                  fillColor: const Color(orange),
                                  textStyle: klasikHeader,
                                  underlineWidth: 3,
                                  cursorColor: const Color(orange),
                                  digitsOnly: true,
                                  autofocus: true,
                                  underlineColor: const Color(darkPurple),
                                  //!in verification page when the code is right no need for the user to press enter instead teh underlienfocusedcolor will be set green and i set an value to that
                                  underlineUnfocusedColor: verified
                                      ? Colors.green
                                      : const Color(orange),
                                  fullBorder: true,
                                  length: 6,
                                  onCompleted: (String value) {},
                                  onEditing: (value) {}),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10),
                              child: Button("Enter", () {
                                setState(() {
                                  verified = true;
                                });
                              }),
                            ),
                            MaterialButton(
                              onPressed: () {
                                reSendPressed++;
                                if (reSendPressed == 1) {
                                  Timer.periodic(const Duration(seconds: 1),
                                      (timer) {
                                    if (time > 0) {
                                      time--;
                                      buttonText =
                                          "Resend Again After $time Seconds.";
                                      setState(() {});
                                    }
                                    if (time == 0) {
                                      reSendPressed = 0;
                                      buttonText = "Resend Code";
                                      timer.cancel();
                                      time = 5;
                                    }
                                    print(time);
                                  });
                                }
                              },
                              child: Text(
                                buttonText,
                                style: klasik,
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class NewPassword extends StatelessWidget {
//! old password controller
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
//! new password controller and func
  NewPassword({super.key});
  bool ispassword = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Row(
              children: [
                BackButton(),
                //! fix this backButton its lead to no where
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  keysIcons,
                  width: 200,
                  height: 200,
                ),
                const Text(
                  "Enter New Password : ",
                  style: klasikHeader,
                ),
                //! password
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: PasswordTextField(
                      controller: passwordController,
                      hint: " Password",
                      isWhite: true,
                    )),
                //! confirm password
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: PasswordTextField(
                      controller: confirmPasswordController,
                      hint: " Confirm Password",
                      isWhite: true,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Button("Enter", () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
