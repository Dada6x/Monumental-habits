import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';

import 'package:monumental_habits/auth/pages/personalInfo.dart';
import 'package:monumental_habits/auth/pages/landing_page.dart';
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
  final String operation = Get.arguments["op"];
  final String email = Get.arguments["email"];
  int? code;
  Color? statusColor;
  @override
  void dispose() {
    super.dispose();
    time = 0;
    verified = false;
  }

  Future<void> checkVerifyRegister() async {
    final request = await Dio().post(options: Options(
      validateStatus: (status) {
        if (status == 401 || status == 200) {
          return true;
        } else {
          return false;
        }
      },
    ), "http://10.0.2.2:8000/api/verificationCode/check",
        data: {"email": email, "code": code, "registration": true});
    print("refisteration");

    var response = request.data;
    if (response["status"]) {
      verified = true;
    }
  }

  Future<void> checkVerifyForgot() async {
    final request = await Dio().post(options: Options(
      validateStatus: (status) {
        if (status == 401 || status == 200) {
          return true;
        } else {
          return false;
        }
      },
    ), "http://10.0.2.2:8000/api/verificationCode/check",
        data: {"email": email, "code": code, "registration": false});
    print("refisteration");

    var response = request.data;
    if (response["status"]) {
      verified = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(background),
        resizeToAvoidBottomInset: true,
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
                  ? NewPassword(
                      email: email,
                      code: code!,
                    )
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
                              child: GetBuilder<verifyController>(
                                init: verifyController(),
                                builder: (controller) {
                                  return VerificationCode(
                                    fillColor: const Color(orange),
                                    textStyle: klasikHeader,
                                    underlineWidth: 3,
                                    cursorColor: const Color(orange),
                                    digitsOnly: true,
                                    autofocus: true,
                                    underlineColor:
                                        statusColor ?? const Color(darkPurple),

                                    //!in verification page when the code is right no need for the user to press enter instead teh underlienfocusedcolor will be set green and i set an value to that
                                    underlineUnfocusedColor:
                                        statusColor ?? const Color(darkPurple),
                                    fullBorder: true,
                                    length: 6,
                                    onCompleted: (value) async {
                                      print("verified status $verified");
                                      code = int.parse(value);
                                      operation == "reg"
                                          ? await checkVerifyRegister()
                                          : await checkVerifyForgot();

                                      if (verified) {
                                        statusColor = Colors.green;
                                        controller.changecolor();
                                        await Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {
                                          if (operation == "reg") {
                                            print(code);
                                            Get.to(
                                              PersonalInfo(
                                                email: email,
                                                code: code!,
                                              ),
                                            );
                                          }
                                          if (operation == "forgot") {
                                            setState(() {});
                                          }
                                        });
                                      }
                                      if (!verified) {
                                        statusColor = Colors.red;
                                        controller.changecolor();
                                        await Future.delayed(
                                            const Duration(milliseconds: 500));
                                      }
                                    },
                                    onEditing: (bool value) {},
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10),
                              child: Button(context, "Enter", () {
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
  final String email;
  final int code;
  bool status = false;
  RegExp symbolRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  RegExp uppercaseRegex = RegExp(r'[A-Z]');
  RegExp numberRegex = RegExp(r'\d');
//! old password controller
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
//! new password controller and func
  NewPassword({super.key, required this.email, required this.code});
  bool ispassword = true;
  Future<void> forgotPass() async {
    final request =
        await Dio().post("http://10.0.2.2:8000/api/password/forget", data: {
      "email": email,
      "code": code,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text
    });
    int? r = request.statusCode;
    print("codeeeeeeeeeeeeee: {$r}");
    var response = request.data;
    if (response["status"]) {
      status = true;
    }
  }

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
                  child: Button(context, "Enter", () async {
                    await forgotPass();
                    if (status) {
                      if (passwordController.text ==
                              confirmPasswordController.text &&
                          numberRegex.hasMatch(passwordController.text) &&
                          uppercaseRegex.hasMatch(passwordController.text) &&
                          symbolRegex.hasMatch(passwordController.text)) {
                        Get.off(const Auth());
                      }
                    }
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class verifyController extends GetxController {
  void changecolor() {
    update();
  }
}
