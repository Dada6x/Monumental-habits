import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/home/homePage.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';
import 'package:monumental_habits/widgets/Buttons.dart';
import 'package:monumental_habits/widgets/text_fields.dart';

class PersonalInfo extends StatelessWidget {
  //!-------------------controllers--------------------------
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //!-------------------controllers--------------------------
  PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const CircleAvatar(
                    radius: 80,
                    backgroundColor: Color(0xFFFFD2AF),
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
                Button("next", () {
                  Get.to(HomePage());
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
          width: SizeConfig.screenWidth * 0.8,
          height: SizeConfig.screenHeight * 0.19,
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
                        // Get.find<SignUpController>().pickImageFromGallery();
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
                        //Get.find<SignUpController>().pickImageFromCamera();
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
  /* XFile? pickedImage;
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
  }*/
}
