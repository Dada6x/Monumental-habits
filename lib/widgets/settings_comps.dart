import 'package:flutter/material.dart';

class SettingsComps extends StatelessWidget {
  final String title;
  final Icon? icon;
  final Function destination;
  final Widget? trailing;
  const SettingsComps(
      {super.key,
      required this.title,
      this.icon,
      required this.destination,
      this.trailing});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        color: Theme.of(context).colorScheme.tertiary,
        child: ListTile(
          onTap: () => destination(),
          title: Text(
            title,
            style: const TextStyle(),
          ),
          leading: icon,
          iconColor: Theme.of(context).colorScheme.primary,
          trailing: trailing,
        ),
      ),
    );
  }
}
