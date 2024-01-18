import 'package:flutter/material.dart';
import 'package:wanda_dairy/screens/choose_account.dart';
import 'package:wanda_dairy/screens/home/dairy_home_page.dart';
import 'package:wanda_dairy/screens/login/login.dart';
import 'package:wanda_dairy/screens/register/register.dart';
import 'package:wanda_dairy/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wanda Dairy',
      theme: AppTheme.theme,
      home: const DairyHomePage(),
    );
  }
}
