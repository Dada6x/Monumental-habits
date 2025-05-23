import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
SnackBar Custom_snackBar(
    BuildContext context, String whatsCopied, String type) {
  return SnackBar(
    content: Text(
      type == "Copy" ? "$whatsCopied Copied !" : "$whatsCopied Updated!",
      style: TextStyle(
          color: Theme.of(context).colorScheme.primary, fontFamily: "klasik"),
    ),
    duration: const Duration(milliseconds: 500),
    backgroundColor: Theme.of(context).colorScheme.onSurface,
  );
}
