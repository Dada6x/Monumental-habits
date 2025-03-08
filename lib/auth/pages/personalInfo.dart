import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/auth/pages/Auth.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/Buttons.dart';
import 'package:monumental_habits/widgets/textfield.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    bool ispassword = true;
    return Scaffold(
      backgroundColor: const Color(background),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SvgPicture.asset(
              "assets/images/BackgroundClouds.svg",
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
                  style: TextStyle(
                      fontFamily: "klasik",
                      fontSize: 24,
                      color: Color(darkPurple)),
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
                        onPressed: () {},
                        elevation: 2,
                        fillColor: Colors.white,
                        padding: const EdgeInsets.all(15.0),
                        shape: const CircleBorder(),
                        child: const Icon(Icons.camera_alt_outlined,
                            color: Color(orange)),
                      )),
                ]),
                const TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Color(orange),
                    labelText: "Name",
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
                projectPasswordTextfieldWhite(ispassword),
                // confirm password
                projectPasswordTextfieldWhite(ispassword),

                Button("next", () {
                  Get.to(const Auth());
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
