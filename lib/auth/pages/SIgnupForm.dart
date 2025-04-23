import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/auth/pages/verificationPage.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/widgets/Buttons.dart';
import 'package:monumental_habits/util/widgets/text_fields.dart';

// ignore: must_be_immutable
class SignupForm extends StatelessWidget {
  Future<void> sendVerifyRegister() async {
    final request = await Dio().post(
        "http://10.0.2.2:8000/api/verificationCode/send",
        data: {"email": emailController.text, "registration": 1});
    var response = request.data;
    print(response);
    if (response["status"]) {
      status = true;
      print(status);
    }
  }

  bool status = false;
  final emailController = TextEditingController();
  final RxBool isChecked = false.obs;
  final formKey = GlobalKey<FormState>();
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
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isNotEmpty && value.length <= 10 ||
                      value.isNotEmpty && !value.contains("@gmail.com")) {
                    return 'Please enter a valid email address with "@gmail.com"';
                  }
                  return null;
                },
                onChanged: (val) {
                  formKey.currentState!.validate();
                },
                decoration: customTextFieldDecoration(
                    hint: "Email",
                    prefixIcon: const Icon(Icons.mail),
                    isWhite: true),
              ),
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
            child: Button(context, "Create Account", () async {
              if (formKey.currentState!.validate()) {
                // print("send request-----------------------");
                await sendVerifyRegister();
                if (status) {
                  Get.to(const VerificationPage(),
                      arguments: {"email": emailController.text, "op": "reg"});
                }
              }
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
            child: googleButton(context),
          ),
          faceBookButton(context),
        ],
      ),
    );
  }
}
