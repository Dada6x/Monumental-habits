import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';

import 'package:monumental_habits/pages/habit/dashboard_homepage/habitTable.dart';
import 'package:monumental_habits/util/helper.dart';

class NetworkStatus extends StatefulWidget {
  //! this is the class the determine that the scaffold going to show damn man or error message
  const NetworkStatus({super.key});

  @override
  State<NetworkStatus> createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {
  bool isConnectedToInternet = false;

  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isConnectedToInternet
        ? HabitTable(key: habitTableKey)
        : Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Lottie.asset('assets/animations/dinolightmode.json'),
                ),
                Text(
                  '  You\'re Offline :(',
                  style: manropeFun(context),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Please Make Sure You\'re Connected To The Internet',
                  style: manropeFun(context),
                ),
              ],
            ),
          );
  }
}
