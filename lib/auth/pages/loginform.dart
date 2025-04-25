import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:monumental_habits/auth/pages/forgetPassword.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/widgets/Buttons.dart';
import 'package:monumental_habits/util/widgets/text_fields.dart';

// ignore: must_be_immutable
class LoginForm extends StatelessWidget {
  Future<void> Login() async {
    print("free ");
    var response = await Dio().post("http://10.0.2.2:8000/api/login", data: {
      'email': emailController.text,
      'password': passwordController.text,
      'timezone': 'Asia/Damascus',
      'fcm_token': 's'
    });

    if (response.data["status"]) {
      token!.setString("token", response.data["token"]);
    } else {
      //@Ward-ikhtiyar add cases exceptions you nigger and add snack bars
    }
  }

  //!-------------------controllers--------------------------
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //!-------------------controllers--------------------------
  bool isPassword = true;
  LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //! Email
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05),
            child: TextField(
              controller: emailController,
              decoration: customTextFieldDecoration(
                  hint: "Email",
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  isWhite: false),
            )),
        //! Password
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05,
                vertical: 8),
            child: PasswordTextField(
              controller: passwordController,
              hint: "password",
            )),
        //! login Button
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.05),
          child: Button(context, "Login", () async {
            await Login();
            if (token!.getString("token") != "") {
              print(token!.getString("token"));
              Get.offNamed("Home");
            }
          }),
        ),
        //! forgot password
        TextButton(
            onPressed: () {
              GoogleSignIn g = GoogleSignIn();
              g.disconnect();
              Get.to(forgetPassword());
            },
            child: Text("Forgot Password ?", style: manropeFun(context))),
      ],
    );
  }
}



