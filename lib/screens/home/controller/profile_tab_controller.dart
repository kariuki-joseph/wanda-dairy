// class that extends getx Controller
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanda_dairy/models/user_model.dart';
import 'package:wanda_dairy/routes/app_routes.dart';

class ProfileTabController extends GetxController {
  // user mode instance
  final Rx<UserModel> savedUser = Rx<UserModel>(UserModel());
  final isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    // get saved user data
    getSavedUser();
  }

  void getSavedUser() async {
    // get user data from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    UserModel user = UserModel(
      id: prefs.getString("userId") ?? "",
      name: prefs.getString("name") ?? "",
      email: prefs.getString("email") ?? "",
      phone: prefs.getString("phone") ?? "",
      isAdmin: prefs.getBool("isAdmin") ?? false,
      password: prefs.getString("password") ?? "",
    );

    savedUser.value = user;
  }

  // logout user and remove shared pref data
  void logout() async {
    isLoading.value = true;
    // logout firebase
    if (_auth.currentUser != null) {
      await _auth.signOut();
    }
    // remove shared pref data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoading.value = false;

    Get.offAllNamed(AppRoute.chooseAccount);
  }
}
