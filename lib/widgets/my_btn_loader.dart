import 'package:flutter/material.dart';

class MyBtnLoader extends StatelessWidget {
  const MyBtnLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(),
    );
  }
}
