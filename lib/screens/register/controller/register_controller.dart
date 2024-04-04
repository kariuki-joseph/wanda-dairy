import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanda_dairy/models/user_model.dart';
import 'package:wanda_dairy/routes/app_routes.dart';
import 'package:wanda_dairy/utils/toast_utils.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);

  final name = "".obs;
  final email = "".obs;
  final phone = "".obs;
  final password = "".obs;
  final confirmPassword = "".obs;
  final isLoading = false.obs;

  UserModel? get user => _userModel.value;

  Future<void> register() async {
    if (!validateDetails()) return;

    isLoading.value = true;
    try {
      // create user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.value, password: password.value);
      if (userCredential.user == null) {
        throw Exception("Unable to register user. Please try again");
      }

      User? firebaseUser = userCredential.user;
      // save user to firestore
      UserModel userModel = UserModel(
        id: firebaseUser!.uid,
        name: name.value,
        email: email.value,
        phone: phone.value,
        isAdmin: true,
        password: password.value,
      );

      await _firestore
          .collection("users")
          .doc(firebaseUser.uid)
          .set(userModel.toMap());

      isLoading.value = false;

      // signin was successful. Redirect to default home pages
      await _saveUserToSharedPrefs(userModel);

      Get.toNamed(AppRoute.dairyHomePage);
    } catch (e) {
      isLoading.value = false;
      showErrorToast(e.toString());
    }
  }

  bool validateDetails() {
    if (name.value.isEmpty) {
      showErrorToast("Please enter your name");
      return false;
    }
    if (email.value.isEmpty) {
      showErrorToast("Please enter your email");
      return false;
    }
    if (phone.value.isEmpty) {
      showErrorToast("Please enter your phone number");
      return false;
    }
    if (password.value.isEmpty) {
      showErrorToast("Please enter your password");
      return false;
    }
    if (confirmPassword.value.isEmpty) {
      showErrorToast("Please confirm your password");
      return false;
    }
    if (password.value != confirmPassword.value) {
      showErrorToast("Passwords do not match");
      return false;
    }
    return true;
  }

  _saveUserToSharedPrefs(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", user.id);
    await prefs.setString("name", user.name);
    await prefs.setString("email", user.email);
    await prefs.setString("phone", user.phone);
    await prefs.setBool("isAdmin", user.isAdmin);
    await prefs.setString("password", user.password);
  }
}
