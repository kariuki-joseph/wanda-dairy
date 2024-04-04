import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/firebase_options.dart';
import 'package:wanda_dairy/models/user_model.dart';
import 'package:wanda_dairy/routes/app_routes.dart';
import 'package:wanda_dairy/screens/login/controller/login_controller.dart';
import 'package:wanda_dairy/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // check if user is logged in and the type of logged in user
  UserModel? loggedInUser = await LoginController.getSavedUser();

  runApp(MyApp(
    loggedInUser: loggedInUser,
  ));
}

class MyApp extends StatelessWidget {
  // create an instance of MaterialTheme
  final MaterialTheme materialTheme = const MaterialTheme(TextTheme());
  // get the logged in user
  final UserModel? loggedInUser;

  const MyApp({
    super.key,
    required this.loggedInUser,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wanda Dairy',
      // light theme
      theme: materialTheme.light(),
      // dark theme
      darkTheme: materialTheme.dark(),
      initialRoute: _getInitialRoute(loggedInUser),
      getPages: AppRoute.routes,
    );
  }

  String _getInitialRoute(UserModel? user) {
    if (user == null) {
      return AppRoute.chooseAccount;
    } else if (user.isAdmin) {
      return AppRoute.dairyHomePage;
    } else {
      return AppRoute.farmerHomePage;
    }
  }
}
