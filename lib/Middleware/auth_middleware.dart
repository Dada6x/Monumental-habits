import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:monumental_habits/main.dart';

class IntroMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (introSP!.getString("intro") != null) {
      print("nameeeee${introSP!.getString("intro")}");
      return const RouteSettings(name: "/Auth");
    }
    if (introSP!.getString("intro") == null) {
      return const RouteSettings(name: "/", arguments: {"name": 2});
    }
  }
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (token!.getString("token") != "") {
      return const RouteSettings(name: "/Home");
    } else {
      return const RouteSettings(name: "/Auth");
    }
  }
}
