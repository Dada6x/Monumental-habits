import 'package:flutter/material.dart';

class FAQPageHeader extends StatelessWidget {
  const FAQPageHeader({super.key, required this.header});
  final String header;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          header,
          style: TextStyle(
              color: Theme.of(context).colorScheme.scrim,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "manrope"),
        ),
      ),
    );
  }
}
