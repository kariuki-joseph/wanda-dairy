import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/firebase_options.dart';
import 'package:wanda_dairy/routes/app_routs.dart';
import 'package:wanda_dairy/screens/choose_account.dart';
import 'package:wanda_dairy/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wanda Dairy',
      theme: AppTheme.theme,
      home: const ChooseAccount(),
      getPages: AppRoute.routes,
    );
  }
}
