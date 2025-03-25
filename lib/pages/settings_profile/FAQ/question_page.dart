import 'package:flutter/material.dart';
class FAQItem {
  String question;
  String categorie;
  String answer;
  FAQItem({
    required this.question,
    required this.answer,
    required this.categorie,
  });
}
class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key, required this.FAQ});
  final FAQItem FAQ;

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionSection(screenheight: screenheight, FAQ: FAQ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                FAQ.answer,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionSection extends StatelessWidget {
  const QuestionSection({
    super.key,
    required this.screenheight,
    required this.FAQ,
  });

  final double screenheight;
  final FAQItem FAQ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenheight / 3,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(
            flex: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Question",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              FAQ.question,
              maxLines: 6,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
