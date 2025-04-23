import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/categories_page.dart';
import 'package:monumental_habits/pages/settings_profile/settings.dart';

class FAQPageCategorie extends StatelessWidget {
  const FAQPageCategorie({
    super.key,
    required this.category,
    required this.icon,
  });
  final String category;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(FAQCateogryPage(category: category));
      },
      child: Card(
        color: Theme.of(context).colorScheme.tertiary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIcons(
                icon: icon,
                color: null,
              ),
              Center(
                child: Text(
                  category.tr,
                  style: TextStyle(color: Theme.of(context).colorScheme.scrim),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
