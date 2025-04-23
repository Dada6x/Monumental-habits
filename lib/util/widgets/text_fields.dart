import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/util/helper.dart';



InputDecoration customTextFieldDecoration(
    {required String hint, required Icon? prefixIcon, required bool isWhite}) {
  return InputDecoration(
    fillColor: isWhite ? Colors.white : const Color(lightOrange),
    focusColor: const Color(orange),
    filled: true,
    prefixIcon: prefixIcon,
    prefixIconColor: const Color(orange),
    labelText: hint,
    labelStyle: klasikHint,
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

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final bool isWhite;
  const PasswordTextField(
      {super.key, required this.controller, this.hint, this.isWhite = false});
  @override
  Widget build(BuildContext context) {
    final isPasswordHidden = true.obs; // Local reactive variable
    return Obx(() => TextField(
          controller: controller,
          obscureText: isPasswordHidden.value,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              color: const Color(orange),
              onPressed: () => isPasswordHidden.value = !isPasswordHidden.value,
              icon: isPasswordHidden.value
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            fillColor: isWhite ? Colors.white : const Color(lightOrange),
            filled: true,
            prefixIcon: const Icon(Icons.lock_open_rounded, color: Color(orange)),
            labelText: hint,
            labelStyle: klasik,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ));
  }
}
