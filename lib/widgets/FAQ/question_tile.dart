import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/question_page.dart';
import 'package:monumental_habits/util/helper.dart';

class QuestionTile extends StatelessWidget {
  const QuestionTile({super.key, required this.FAQ});
  final FAQItem FAQ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Card(
        margin: const EdgeInsets.only(top: 10),
        elevation: 0,
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          onTap: () {
            Get.to(QuestionPage(FAQ: FAQ));
          },
          title: Text(
            FAQ.question,
            style: manropeFun(context),
          ),
          tileColor: Theme.of(context).colorScheme.tertiary,

          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Theme.of(context).colorScheme.primaryFixed,
            shadows: [
              Shadow(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  blurRadius: 8)
            ],
          ),
          // iconColor: Colors.black45,
        ),
      ),
    );
  }
}
