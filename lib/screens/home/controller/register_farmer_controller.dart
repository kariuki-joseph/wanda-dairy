import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/models/user_model.dart';
import 'package:wanda_dairy/utils/toast_utils.dart';

class RegisterFarmerController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);

  final name = "".obs;
  final email = "".obs;
  final phone = "".obs;
  final password = "".obs;
  final isLoading = false.obs;
  final registerSuccess = false.obs;

  UserModel? get user => _userModel.value;

  Future<void> registerFarmer() async {
    if (!_validateDetails()) return Future.value();
    isLoading.value = true;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.value, password: password.value);

      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        name: name.value,
        email: email.value,
        phone: phone.value,
        isAdmin: false,
        password: password.value,
      );

      await _firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

      isLoading.value = false;
      registerSuccess.value = true;

      showSuccessToast("Farmer registered successfully");
      // clear fields
      _clearFields();
    } catch (e) {
      isLoading.value = false;
      showErrorToast(e.toString());
    }
  }

  bool _validateDetails() {
    if (name.value.isEmpty) {
      showErrorToast("Name is required");
      return false;
    }

    if (email.value.isEmpty) {
      showErrorToast("Email is required");
      return false;
    }

    if (phone.value.isEmpty) {
      showErrorToast("Phone is required");
      return false;
    }

    if (password.value.isEmpty) {
      showErrorToast("Password is required");
      return false;
    }

    return true;
  }

  void _clearFields() {
    name.value = "";
    email.value = "";
    phone.value = "";
    password.value = "";
  }
}
