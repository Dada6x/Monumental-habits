import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/auth/pages/personalInfo.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/customappBar.dart';
import 'package:monumental_habits/widgets/settingsFunctions.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});
  Widget divider(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.secondary,
      thickness: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappBar([], "Account Details".tr, context),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).colorScheme.primaryFixed,
                      blurRadius: 7)
                ]),
            child: Stack(children: [
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
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.tertiary,
              child: Column(
                children: [
                  SettingsFunctions(
                    leading: "Username :",
                    text: "Ward-Ek",
                  ),
                  divider(context),
                  SettingsFunctions(
                    leading: "Email :",
                    text: "Wardekr@gmail.com",
                  ),
                  divider(context),
                  SettingsFunctions(
                    leading: "Password :",
                    text: "********",
                  ),
                  divider(context),
                  SettingsFunctions(
                    leading: "Timezone :",
                    text: "Asia/Damascus",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
