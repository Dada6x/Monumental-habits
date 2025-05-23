import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/auth/pages/Models/Profile_models.dart';
import 'package:monumental_habits/pages/settings_profile/profile.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/widgets/Custom_snackBar.dart';

class UpdateDialog extends StatelessWidget {
  UpdateDialog({
    super.key,
    required this.textFieldContent,
  });
  final nameController = TextEditingController();
  final String textFieldContent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Theme.of(context).colorScheme.tertiary,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Edit $textFieldContent".tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.scrim,
                    fontFamily: "klasik"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    prefixIcon: const Icon(Icons.edit),
                    prefixIconColor: Theme.of(context).colorScheme.scrim,
                    hintText: "New $textFieldContent".tr,
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: nameController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: Text(
                      'back'.tr,
                      style: klasik,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: Text(
                      'Update'.tr,
                      style: klasik,
                    ),
                    onPressed: () async {
                      bool answer = await ProfileModels.UpdateUserRequest(
                          nameController.text, null);
                      if (answer) {
                        Get.back();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              Custom_snackBar(
                                  context, textFieldContent, "Update"));
                        }
                        await Future.delayed(const Duration(seconds: 1));
                        Get.offUntil(
                          MaterialPageRoute(builder: (_) => ProfilePage()),
                          (route) => route
                              .isFirst, // Removes all screens except the first one
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
