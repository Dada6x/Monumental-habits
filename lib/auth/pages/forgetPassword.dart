import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:monumental_habits/auth/pages/landing_page.dart';
import 'package:monumental_habits/auth/pages/verificationPage.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/Buttons.dart';
import 'package:monumental_habits/widgets/text_fields.dart';

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
            const Text("Forgot your password ?", style: klasikHeader),
            Center(child: SvgPicture.asset(forgotPassword)),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          decoration: customTextFieldDecoration(
                              hint: "",
                              prefixIcon: const Icon(Icons.mail),
                              isWhite: false),
                        ),
                      ),
                      Button("Send link", () {
                        Get.to(const VerificationPage());
                      })
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Remember password?",
                  style: manropeFun(context),
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
