import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/auth/pages/personalInfo.dart';
import 'package:monumental_habits/util/widgets/customappBar.dart';
import 'package:monumental_habits/util/widgets/settingsFunctions.dart';

// ignore: must_be_immutable
class ProfileDetails extends StatelessWidget {
  var user_data = Get.arguments["data"];

  ProfileDetails({super.key});
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
              CircleAvatar(
                radius: 80,
                backgroundColor:
                    Theme.of(context).colorScheme.primaryFixed.withOpacity(0.5),
                foregroundImage: NetworkImage(user_data["user"]["photo"]),
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
                    child: Icon(Icons.camera_alt_outlined,
                        color: Theme.of(context).colorScheme.primaryFixed),
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
                    text: user_data["user"]["name"],
                  ),
                  divider(context),
                  SettingsFunctions(
                    leading: "Email :",
                    text: user_data["user"]["email"],
                  ),
                  divider(context),
                  SettingsFunctions(
                    leading: "Password :",
                    text: "********",
                  ),
                  divider(context),
                  SettingsFunctions(
                    leading: "Timezone :",
                    text: user_data["user"]["timezone"],
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
