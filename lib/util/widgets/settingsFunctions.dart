import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monumental_habits/util/widgets/Custom_snackBar.dart';

// ignore: must_be_immutable
class SettingsFunctions extends StatelessWidget {
  SettingsFunctions({
    super.key,
    this.leading,
    required this.text,
    this.subtitle,
    this.textToCopy,
    this.whatsCopied,
    this.func,
    required this.type,
  });
  String? leading;
  final String text;
  String? subtitle;
  String? textToCopy;
  String? whatsCopied;
  Function? func;
  final String type;
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
          onLongPress: () async {
            if (func == null) {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context)
                  .showSnackBar(Custom_snackBar(context, whatsCopied!, type));
            } else {
              func!();
            }
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
