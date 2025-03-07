import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/auth/forgetPassword.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/Buttons.dart';

Widget LoginColumn(double width) {
  bool ispassword = true;
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: TextFormField(
          decoration: const InputDecoration(
            fillColor: Color(lightorange),
            filled: true,
            prefixIcon: Icon(Icons.person, color: Color(orange)),
            labelText: "Email",
            labelStyle: klasik,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(orange)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 8),
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
            labelText: "Password",
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
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        //! login Button
        child: Button("Login", () {}),
      ),
      //! forgot password
      TextButton(
          onPressed: () {
            Get.to(const Forgetpassword());
          },
          child: const Text("Forgot Password ?", style: manrope)),
    ],
  );
}
//! inputDecoration of the textFiles
