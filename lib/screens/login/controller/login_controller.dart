import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanda_dairy/models/user_model.dart';
import 'package:wanda_dairy/routes/app_routes.dart';
import 'package:wanda_dairy/utils/toast_utils.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<UserModel?> loggedInuser = Rx<UserModel?>(null);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;

  UserModel? get user => loggedInuser.value;

  @override
  void onInit() async {
    super.onInit();

    loggedInuser.value = await getSavedUser();
  }

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userCredential.user == null) {
        throw Exception("Unable to login user. Please try again");
      }
      // get user data from firestore
      User? firebaseUser = userCredential.user;

      await _firestore
          .collection("users")
          .doc(firebaseUser!.uid)
          .get()
          .then((doc) {
        loggedInuser.value = UserModel.fromDocument(doc);
      });

      isLoading.value = false;
      // signin was successful. Save user details to shared preferences
      await _saveUserToSharedPrefs(loggedInuser.value);

      // show login success toast
      showSuccessToast("Login successful");

      if (user!.isAdmin) {
        Get.offAllNamed(AppRoute.dairyHomePage);
      } else {
        Get.offAllNamed(AppRoute.farmerHomePage);
      }
    } catch (e) {
      isLoading.value = false;
      showErrorToast(e.toString());
    }
  }

  _saveUserToSharedPrefs(UserModel? user) async {
    if (user == null) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", user.id);
    await prefs.setString("name", user.name);
    await prefs.setString("email", user.email);
    await prefs.setString("phone", user.phone);
    await prefs.setBool("isAdmin", user.isAdmin);
    await prefs.setString("password", user.password);
  }

  static Future<UserModel?> getSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId") ?? "";
    String name = prefs.getString("name") ?? "";
    String email = prefs.getString("email") ?? "";
    String phone = prefs.getString("phone") ?? "";
    bool isAdmin = prefs.getBool("isAdmin") ?? false;
    String password = prefs.getString("password") ?? "";

    if (userId.isEmpty) {
      return null;
    }

    return UserModel(
      id: userId,
      name: name,
      email: email,
      phone: phone,
      isAdmin: isAdmin,
      password: password,
    );
  }
}
