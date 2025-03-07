import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monumental_habits/util/helper.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(signupImg);
  }
}
