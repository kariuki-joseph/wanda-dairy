import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:wanda_dairy/screens/choose_account.dart';
import 'package:wanda_dairy/screens/home/dairy_home_page.dart';
import 'package:wanda_dairy/screens/home/farmer_home_page.dart';
import 'package:wanda_dairy/screens/login/login.dart';
import 'package:wanda_dairy/screens/register/register.dart';

class AppRoute {
  static const chooseAccount = "/ChooseAcount";
  static const dairyHomePage = "/DairyHomePage";
  static const farmerHomePage = "/FarmerHomePage";
  static const register = "/Register";
  static const login = "/Login";

  static List<GetPage> routes = [
    GetPage(name: chooseAccount, page: () => const ChooseAccount()),
    GetPage(name: dairyHomePage, page: () => const DairyHomePage()),
    GetPage(name: farmerHomePage, page: () => const FarmerHomePage()),
    GetPage(name: register, page: () => const Register()),
    GetPage(name: login, page: () => const Login()),
  ];
}
