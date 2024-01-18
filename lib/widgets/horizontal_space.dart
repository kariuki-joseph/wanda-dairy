import 'package:flutter/material.dart';

class HorizontaSpace extends StatelessWidget {
  final double mWidth;
  const HorizontaSpace({Key? key, required this.mWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mWidth,
    );
  }
}
