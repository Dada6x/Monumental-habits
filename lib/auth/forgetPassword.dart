import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:monumental_habits/auth/Auth.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/Buttons.dart';
import 'package:monumental_habits/widgets/textfield.dart';

class forgetPassword extends StatelessWidget {
  const forgetPassword({super.key});

//! textfield controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(background),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [BackButton()],
              ),
            ),
            const Text(
              "Forgot your password ?",
              style: TextStyle(
                  fontFamily: "klasik", fontSize: 24, color: Color(darkPurple)),
            ),
            Center(child: SvgPicture.asset("assets/images/ForgotPassword.svg")),
            Padding(
              padding: const EdgeInsets.all(20),
              //! put the container in the util
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                            decoration: customTextFieldDecoration(
                                hint: "", prefixIcon: null)),
                      ),
                      Button("Send link", () {})
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
      ),
    );
  }
}
