import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:wanda_dairy/screens/choose_account.dart';
import 'package:wanda_dairy/screens/home/dairy_home_page.dart';
import 'package:wanda_dairy/screens/home/farmer_home_page.dart';
import 'package:wanda_dairy/screens/login/admin_login.dart';
import 'package:wanda_dairy/screens/login/farmer_login.dart';
import 'package:wanda_dairy/screens/register/register_admin.dart';

class AppRoute {
  static const chooseAccount = "/choose-account";
  static const dairyHomePage = "/dairy-homepage";
  static const farmerHomePage = "/farmer-homepage";
  static const registerAdmin = "/register/admin";
  static const adminLogin = "/login/admin";
  static const farmerLogin = "/login/farmer";

  static List<GetPage> routes = [
    GetPage(name: chooseAccount, page: () => const ChooseAccount()),
    GetPage(name: dairyHomePage, page: () => const DairyHomePage()),
    GetPage(name: farmerHomePage, page: () => const FarmerHomePage()),
    GetPage(name: registerAdmin, page: () => const RegisterAdmin()),
    GetPage(
      name: adminLogin,
      page: () => const AdminLogin(),
    ),
    GetPage(
      name: farmerLogin,
      page: () => const FarmerLogin(),
    ),
  ];
}
