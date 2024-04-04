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
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              top,
              const SizedBox(height: 5.0),
              Positioned(
                bottom: 0,
                child: bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
