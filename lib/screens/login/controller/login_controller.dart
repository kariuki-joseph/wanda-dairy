import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/models/user_model.dart';
import 'package:wanda_dairy/routes/app_routs.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);

  final email = "".obs;
  final password = "".obs;
  final isLoading = false.obs;

  UserModel? get user => _userModel.value;

  @override
  void onInit() {
    super.onInit();
    _userModel.bindStream(_auth.authStateChanges().asyncMap((user) {
      if (user != null) {
        return _firestore.collection("users").doc(user.uid).get().then((doc) {
          return UserModel.fromDocument(doc);
        });
      } else {
        return Future.value(null);
      }
    }));
  }

  Future<void> signIn() async {
    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.value, password: password.value);

      isLoading.value = false;
      // signin was successful. Redirect to default home pages
      if (user!.isAdmin) {
        Get.offAllNamed(AppRoute.dairyHomePage);
      } else {
        Get.offAllNamed(AppRoute.farmerHomePage);
      }
    } catch (e) {
      isLoading.value = false;

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
