import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:monumental_habits/auth/pages/landing_page.dart';
import 'package:monumental_habits/auth/pages/verificationPage.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/Buttons.dart';
import 'package:monumental_habits/widgets/text_fields.dart';

// ignore: must_be_immutable
class forgetPassword extends StatelessWidget {
  Future<void> sendVerifyForgot() async {
    final request = await Dio().post(
        "http://10.0.2.2:8000/api/verificationCode/send",
        data: {"email": emailController.text, "registration": 0});
    var response = request.data;
    if (response["status"]) {
      status = true;
    }
  }

  bool status = false;
  final emailController = TextEditingController();
  forgetPassword({super.key});
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
                          controller: emailController,
                          decoration: customTextFieldDecoration(
                              hint: "",
                              prefixIcon: const Icon(Icons.mail),
                              isWhite: false),
                        ),
                      ),
                      Button(context, "Send link", () async {
                        await sendVerifyForgot();
                        print(status);
                        if (status) {
                          Get.to(const VerificationPage(), arguments: {
                            "email": emailController.text,
                            "op": "forgot",
                          });
                        }
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
