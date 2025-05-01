import 'package:flutter/material.dart';
import 'package:monumental_habits/Core/api/api_conumer.dart';
import 'package:monumental_habits/Core/api/end_points.dart';

class Exampleofcallingrequest {
  late final ApiConumer api;
  TextEditingController controller = TextEditingController();

  signInRequest() {
    api.post(
      EndPoints.Signin, // the EndPoint
      data: {
        ApiKey.email: controller.text, // "email": controller
        ApiKey.password: controller.text
      },
    );
  }
}
