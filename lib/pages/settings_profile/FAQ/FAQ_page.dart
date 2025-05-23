import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/f_a_q_controller.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/question_page.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/widgets/FAQ/f_a_q_page_categorie.dart';
import 'package:monumental_habits/util/widgets/FAQ/question_tile.dart';
import 'package:monumental_habits/util/widgets/customappBar.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<FAQItem> faqItems = Get.find<FAQController>().QuestionList();

    return Scaffold(
      appBar: customappBar([], "FAQ".tr, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Text("----------  Categories  ---------- ".tr,
                  style: headerStyle(context)),
            ),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: (144 / 100),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                const FAQPageCategorie(
                  category: "Account",
                  icon: Icons.person,
                ),
                FAQPageCategorie(
                  category: "Privacy Policy".tr,
                  icon: Icons.security,
                ),
                FAQPageCategorie(
                  category: "Payment".tr,
                  icon: Icons.sticky_note_2,
                ),
                FAQPageCategorie(
                  category: "Patreon".tr,
                  icon: Icons.propane,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Text(" -----  Recent Questions  ----- ".tr,
                  style: headerStyle(context)),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                return QuestionTile(FAQ: faqItems[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}
