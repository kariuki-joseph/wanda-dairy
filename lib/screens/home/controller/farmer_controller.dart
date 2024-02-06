import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wanda_dairy/models/milk_collection.dart';
import 'package:wanda_dairy/utils/toast_utils.dart';

//
class FarmerController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final User? loggedInUser = FirebaseAuth.instance.currentUser;
  // store milk collections for this user
  final RxList<MilkCollection> milkCollections = <MilkCollection>[].obs;

  Future<void> getSummary() async {}
  final viewModeObs = ViewMode.daily.obs;

  final litresDelivered = 0.0.obs;
  final pricePerLitre = 0.0.obs;
  final totalEarnings = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getDailySummary();
  }

  Future<void> getDailySummary({
    String? collectionDate,
    ViewMode viewMode = ViewMode.daily,
  }) async {
    viewModeObs.value = viewMode;

    if (collectionDate != null) {
      collectionDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
    }

    try {
      QuerySnapshot querySnapshot = await _fireStore
          .collection("milk_collections")
          .where("farmerId", isEqualTo: loggedInUser!.uid)
          .where("collectionDate", isEqualTo: collectionDate)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        milkCollections.value = MilkCollection.fromQuerySnapshot(querySnapshot);
      }
    } catch (e) {
      showErrorToast(e.toString());
    }
  }
}

enum ViewMode { daily, monthly }
