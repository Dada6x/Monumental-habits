import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/f_a_q_controller.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/question_page.dart';
import 'package:monumental_habits/util/widgets/FAQ/question_tile.dart';
import 'package:monumental_habits/util/widgets/customappBar.dart';

// ignore: must_be_immutable
class FAQCateogryPage extends StatelessWidget {
  final String category;
  List<FAQItem>? filteredlist;
  FAQCateogryPage({super.key, required this.category}) {
    filteredlist = Get.find<FAQController>()
        .QuestionList()
        .where(
            (element) => element.categorie.isCaseInsensitiveContains(category))
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappBar([], category, context),
      body: ListView(children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredlist!.length,
            itemBuilder: (context, index) {
              return QuestionTile(FAQ: filteredlist![index]);
            }),
      ]),
    );
  }
}
