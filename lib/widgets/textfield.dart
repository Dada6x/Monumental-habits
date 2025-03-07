import 'package:flutter/material.dart';
import 'package:monumental_habits/util/helper.dart';



//! THIS DOSENT WORK بس تمشاية حال

Widget projectPasswordTextfield(bool ispassword) {
  return TextFormField(
    obscureText: ispassword,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        color: const Color(orange),
        onPressed: () {
          ispassword = !ispassword;
        },
        icon: ispassword
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility),
      ),
      fillColor: const Color(lightOrange),
      filled: true,
      prefixIcon: const Icon(Icons.key, color: Color(orange)),
      labelText: "Password",
      labelStyle: klasik,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(orange)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}

InputDecoration customTextFieldDecoration(
    {required String hint, required Icon? prefixIcon}) {
  return InputDecoration(
    fillColor: const Color(lightOrange),
    focusColor: const Color(orange),
    filled: true,
    prefixIcon: prefixIcon,
    prefixIconColor: const Color(orange),
    labelText: hint,
    labelStyle: klasik,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(orange)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
}
