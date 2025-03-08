import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/auth/pages/forgetPassword.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';
import 'package:monumental_habits/widgets/Buttons.dart';
import 'package:monumental_habits/widgets/textfield.dart';

// ignore: must_be_immutable
class LoginForm extends StatelessWidget {
  // email controller
  // password controller
  // password security fun
  bool isPassword = true;
  LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //! Email
        Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
            child: TextField(
              decoration: customTextFieldDecoration(
                  hint: "Email", prefixIcon: const Icon(Icons.person)),
            )),
        //! Password
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05, vertical: 8),
            //@ THE SHOW AND UNSHOW DOSENT WORK cant setstate or refuse to login if empty
            child: projectPasswordTextfield(isPassword)),
        //! login Button
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
          child: Button("Login", () {
            //login function
          }),
        ),
        //! forgot password
        TextButton(
            onPressed: () {
              Get.to(const forgetPassword());
            },
            child: const Text("Forgot Password ?", style: manrope)),
      ],
    );
  }
}
//! inputDecoration of the textFiles
