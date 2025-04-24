import 'package:flutter/material.dart';
import 'package:monumental_habits/util/helper.dart';

class SoonWidget extends StatelessWidget {
  const SoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.47,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        // color: Colors.amber,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              // fit: BoxFit.fitHeight,
                              "assets/images/Screenshot_1745499895.png",
                            ),
                          )),
                          const VerticalDivider(
                            endIndent: 19,
                            indent: 19,
                          ),
                          Expanded(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              // fit: BoxFit.fitHeight,
                              "assets/images/Screenshot_1745499895.png",
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Community Comming Soon..",
                    style: klasik,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
