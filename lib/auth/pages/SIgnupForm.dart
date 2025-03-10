import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/auth/pages/personalInfo.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/Buttons.dart';

// ignore: must_be_immutable
class SignupForm extends StatelessWidget {
//! name controller
//! password controller
//! confirm password controller and func

  bool check = true;
  SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SvgPicture.asset(signupImg),
          const Text(
            "Create your account",
            style: TextStyle(
                fontFamily: "klasik", fontSize: 24, color: Color(darkPurple)),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.mail),
                prefixIconColor: Color(orange),
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
            padding: const EdgeInsets.all(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: check,
                  onChanged: (vla) {},
                  activeColor: const Color(orange),
                ),
                const Text(
                  "Email me about special pricing and more",
                  style: manrope,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Button("Create Account", () {
              Get.off(const PersonalInfo());
            }),
          ),
          //! divider
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Divider(),
                  ),
                ),
                Text('Or sign in with'),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GoogleButton(),
          ),
          faceBookButton(),
        ],
      ),
    );
  }
}
