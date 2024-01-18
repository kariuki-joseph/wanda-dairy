import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final VoidCallback onTap;
  final Widget top;
  final Widget bottom;

  const InfoBox({
    super.key,
    required this.top,
    required this.bottom,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 156,
        height: 90,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            top,
            const SizedBox(height: 5.0),
            bottom,
          ],
        ),
      ),
    );
  }
}
