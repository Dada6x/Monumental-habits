import 'package:flutter/material.dart';
import 'package:monumental_habits/util/helper.dart';

class SoonWidget extends StatelessWidget {
  final String widgetName;
  final String image1path;
  final String image2path;
  SoonWidget(
      {super.key,
      required this.widgetName,
      required this.image1path,
      required this.image2path});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            color: Theme.of(context).colorScheme.tertiary,
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
                              image1path,
                            ),
                          )),
                          VerticalDivider(
                            color: Colors.grey.shade600,
                            endIndent: 19,
                            indent: 19,
                          ),
                          Expanded(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              // fit: BoxFit.fitHeight,
                              image2path,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "$widgetName Comming Soon..",
                    style: klasikFun(context)
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
