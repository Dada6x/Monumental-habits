import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class SettingsFunctions extends StatelessWidget {
  SettingsFunctions(
      {super.key,
      this.leading,
      required this.text,
      this.subtitle,
      this.textToCopy,
      this.whatsCopied});
  String? leading;
  final String text;
  String? subtitle;
  String? textToCopy;
  String? whatsCopied;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.tertiary,
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: text));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "$whatsCopied Copied !",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: "klasik"),
              ),
              duration: const Duration(milliseconds: 500),
              backgroundColor: Theme.of(context).colorScheme.onSurface,
            ));
          },
          leading: leading == null
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Text(
                    leading!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontFamily: "Manrope",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          title: Text(
            text,
            style: subtitle == null
                ? const TextStyle(
                    fontFamily: "manrope",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey)
                : TextStyle(
                    color: Theme.of(context).colorScheme.scrim,
                    fontFamily: "Manrope",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          subtitle: subtitle == null ? null : Text(subtitle!),
        ),
      ),
    );
  }
}
