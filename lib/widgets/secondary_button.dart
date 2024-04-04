import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final Function() onPressed;
  final Widget label, icon;
  final bool isEnabled;

  const SecondaryButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.icon,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: label,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      ),
      icon: icon,
    );
  }
}
