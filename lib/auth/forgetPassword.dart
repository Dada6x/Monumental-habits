import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:monumental_habits/auth/Auth.dart';
import 'package:monumental_habits/auth/verificationPage.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';
import 'package:monumental_habits/widgets/Buttons.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(background),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [BackButton()],
          ),
          const Text(
            "Forgot your password?",
            style: TextStyle(
                fontFamily: "klasik", fontSize: 24, color: Color(darkPurple)),
          ),
          Center(child: SvgPicture.asset("assets/images/ForgotPassword.svg")),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                          textAlign: TextAlign.center,
                          "Enter your registered email below to receive password reset instruction"),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(),
                    ),
                    Button("Send link", () {
                      Get.to(VerificationPage());
                      /* Get.dialog(Dialog(
                        child: SizedBox(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.3,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Enter The 6 Digit Code \n \t \t \t Sent Via Email :",
                                  style: klasik,
                                ),
                                VerificationCode(
                                    underlineColor: Color(darkPurple),
                                    underlineUnfocusedColor: Color(orange),
                                    fullBorder: true,
                                    length: 6,
                                    onCompleted: (String value) {},
                                    onEditing: (value) {}),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize:
                                        Size(SizeConfig.screenWidth * 0.6, 42),
                                    backgroundColor: const Color(orange),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Enter",
                                    style: manrope,
                                  ),
                                )
                              ]),
                        ),
                      ));*/
                    })
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Remember password?",
                style: manrope,
              ),
              TextButton(
                  onPressed: () {
                    Get.off(const Auth());
                  },
                  child: const Text("Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(orange),
                      )))
            ],
          )
        ],
      ),
    );
  }
}
