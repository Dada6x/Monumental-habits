import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/auth/pages/personalInfo.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/Buttons.dart';
import 'package:monumental_habits/widgets/text_fields.dart';

class SignupForm extends StatelessWidget {
  final emailController = TextEditingController();
  final RxBool isChecked = false.obs; 

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
            style: klasikHeader,
          ),
          const SizedBox(height: 20),
          //! Email Input
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              decoration: customTextFieldDecoration(
                  hint: "Email",
                  prefixIcon: const Icon(Icons.mail),
                  isWhite: true),
            ),
          ),
          //! Checkbox
          Padding(
            padding: const EdgeInsets.all(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() => Checkbox(
                      value: isChecked.value,
                      onChanged: (value) => isChecked.value = value!,
                      activeColor: const Color(darkOrange),
                    )),
                Text(
                  "Email me about special pricing and more",
                  style: manropeFun(context),
                ),
              ],
            ),
          ),
          //! Create Account Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Button("Create Account", () {
              Get.off(PersonalInfo(), arguments: {
                //? notes
                //! how to pass the arguments dammmn
                // "email": emailController.text,
                // "isChecked": isChecked.value, // Pass checkbox value
                //! and this how to recive them in the personalInfo class
                // final String email = Get.arguments["email"];
                // final bool isChecked = Get.arguments["isChecked"];
              });
            }),
          ),

          //! Divider
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
          //! Social Media Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: googleButton(),
          ),
          faceBookButton(),
        ],
      ),
    );
  }
}
