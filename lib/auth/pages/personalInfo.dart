import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monumental_habits/home/homePage.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/widgets/Buttons.dart';
import 'package:monumental_habits/util/widgets/text_fields.dart';
import 'package:monumental_habits/main.dart';

// ignore: must_be_immutable
class PersonalInfo extends StatelessWidget {
  bool registerStatus = false;
  final String email;
  final int code;
  Future<void> register() async {
    print(email);
    print(code);
    print(nameController.text);
    print(passwordController.text);
    print(confirmPasswordController.text);

    var data = dio.FormData.fromMap({
      "name": nameController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "email": email,
      "code": code,
      "timezone": "Asia/Damascus",
      "fcm_token": "sometoken",
      "photo": await dio.MultipartFile.fromFile(
        Get.find<SignUpController>().returnedImage!.path,
      ),
    });
    final request =
        await dio.Dio().post("http://10.0.2.2:8000/api/register", data: data);
    if (request.data["status"]) {
      token!.setString("token", request.data["token"]);
      registerStatus = true;
    }
  }

  //!-------------------controllers--------------------------
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //!-------------------controllers--------------------------
  PersonalInfo({super.key, required this.email, required this.code});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Scaffold(
      backgroundColor: const Color(background),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SvgPicture.asset(
              backGround,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Set Your personal Info ",
                  style: klasikHeader,
                ),
                Stack(children: [
                  //! need some work for updating the image
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: const Color(0xFFFFD2AF),
                    foregroundImage:
                        Get.find<SignUpController>().returnedImage == null
                            ? null
                            : FileImage(
                                Get.find<SignUpController>().returnedImage!),
                  ),
                  Positioned(
                      bottom: 1,
                      right: -10,
                      height: 49,
                      child: RawMaterialButton(
                        onPressed: () {
                          Get.dialog(const imagepickerdialog());
                        },
                        elevation: 2,
                        fillColor: Colors.white,
                        padding: const EdgeInsets.all(15.0),
                        shape: const CircleBorder(),
                        child: const Icon(Icons.camera_alt_outlined,
                            color: Color(orange)),
                      )),
                ]),
                //! name
                TextField(
                  controller: nameController,
                  decoration: customTextFieldDecoration(
                      hint: "Name",
                      prefixIcon: const Icon(Icons.person),
                      isWhite: true),
                ),
                //! password
                PasswordTextField(
                  controller: passwordController,
                  hint: "Password",
                  isWhite: true,
                ),
                //! confirm Password
                PasswordTextField(
                  controller: confirmPasswordController,
                  hint: "Confirm Password",
                  isWhite: true,
                ),
                Button(context, "next", () async {
                  await register();
                  if (registerStatus) {
                    Get.off(HomePage());
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class imagepickerdialog extends StatelessWidget {
  const imagepickerdialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.19,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.find<SignUpController>().pickImageFromGallery();
                      },
                      icon: const Icon(
                        Icons.image,
                        size: 40,
                        color: Color(orange),
                      ),
                    ),
                    Text(
                      "Gallery",
                      style: manropeFun(context),
                    )
                  ],
                ), //go to the full map
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.find<SignUpController>().pickImageFromCamera();
                      },
                      icon: const Icon(
                        Icons.camera,
                        size: 40,
                        color: Color(orange),
                      ),
                    ),
                    Text(
                      "Camera",
                      style: manropeFun(context),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpController extends GetxController {
  XFile? pickedImage;
  File? returnedImage;
  Future pickImageFromCamera() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      returnedImage = File(pickedImage!.path);
    }
    update();
  }

  Future pickImageFromGallery() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      returnedImage = File(pickedImage!.path);
    }
    update();
  }
}
