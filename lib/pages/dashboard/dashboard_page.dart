import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monumental_habits/pages/dashboard/habit_table.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final String randomQuote = getRandomQuote();
    final List<String> quoteParts = randomQuote.split('-');
    final String quoteText = quoteParts.first.trim();
    final String author =
        quoteParts.length > 1 ? "- ${quoteParts.last.trim()}" : "- Unknown";

    return SingleChildScrollView(
      child: Column(
        children: [
          //! Random Quote
          Padding(
            padding: const EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.2,
                ),
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    quoteText, // the QUOTE ITSELF NIGGA
                                    style: klasikFun(context),
                                    softWrap: true,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: Text(
                                    author,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "manrope",
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            flex: 1,
                            child: SvgPicture.asset(
                              "assets/images/Habits.svg",
                              fit: BoxFit.contain,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //!  Habit Table
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.54,
              child: HabitTable(),
            ),
          ),
        ],
      ),
    );
  }

//! randomQuotes
  String getRandomQuote() {
    final List<String> quotes = [
      "We first make our habits, and then our habits make us. - John Dryden",
      "I hate NIGGAS . -  fiodour Yahea Dada",
      "Success is the sum of small efforts, repeated day in and day out. - Robert Collier",
      "The secret of getting ahead is getting started. - Mark Twain",
      "Motivation is what gets you started. Habit is what keeps you going. - Jim Ryun",
      "Your future is created by what you do today, not tomorrow. - Robert Kiyosaki",
      "Don't watch the clock do what it does. Keep going!!. - Sam Levenson",
    ];
    return quotes[Random().nextInt(quotes.length)];
  }
}
