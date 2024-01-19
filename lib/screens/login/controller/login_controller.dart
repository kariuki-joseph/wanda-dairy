import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/models/user_model.dart';
import 'package:wanda_dairy/routes/app_routs.dart';
import 'package:wanda_dairy/utils/toast_utils.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);

  final email = "".obs;
  final password = "".obs;
  final isLoading = false.obs;

  UserModel? get user => _userModel.value;

  Future<void> signIn() async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.value, password: password.value);
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
        _userModel.value = UserModel.fromDocument(doc);
      });

      isLoading.value = false;
      // signin was successful. Redirect to default home pages
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
}
