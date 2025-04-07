import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/question_page.dart';

class FAQController extends GetxController {
  FAQItem q1 = FAQItem(
      question: "what do you think of the ongoing war in mars?",
      answer: "Allegadly they have reached intercheecks travel.",
      categorie: "Account");
  FAQItem q2 = FAQItem(
      question:
          "How do you interpret the military advances occuring in uganda? how is your family doing there?",
      answer: "I'm khwaite",
      categorie: "Privacy Policy");
  FAQItem q3 = FAQItem(
      question:
          "On scale form 1 to 10 how likely are you to eat the leftover pizza?",
      answer: "I'm mexican fo, i don eat pissas i looofe tacos.",
      categorie: "Payment");
  FAQItem q4 = FAQItem(
      question: "Would you rather........",
      answer: "yeah imma do it",
      categorie: "Account");
  FAQItem q5 = FAQItem(
      question:
          "Merry chirstmas to yall, i hope jesus our lord and savoir helps us through this life for one more year!",
      answer:
          "Ay MO come here, its our turn the tree is fress let's couple snaps.",
      categorie: "Privacy Policy");
  FAQItem q6 = FAQItem(
      question: "Lastely is you didn't get any of the bits above",
      answer: "Congrats you're retarded!",
      categorie: "Pateron");

  List<FAQItem> QuestionList() {
    return [q1, q2, q3, q4, q5, q6];
  }
}