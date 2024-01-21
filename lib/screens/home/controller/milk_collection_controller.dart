import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wanda_dairy/models/milk_collection.dart';
import 'package:wanda_dairy/models/user_model.dart';
import 'package:wanda_dairy/utils/toast_utils.dart';

class MilkCollectionController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<MilkCollection> milkCollections = <MilkCollection>[].obs;
  final Rx<UserModel> selectedFarmer = UserModel().obs;
  // user input controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController milkVolumeController = TextEditingController();
  final TextEditingController pricePerLtrController = TextEditingController();
  final TextEditingController earningsController = TextEditingController();

  // form key for form validations
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // track loading state
  final isLoading = false.obs;

  // auto re-calculate daily earnings
  final volumeOfMilk = "".obs;
  final pricePerLitre = "".obs;

  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();

    // set default form field values
    dateController.text = DateFormat("dd/MM/yyyy").format(selectedDate.value);
    earningsController.text = "Ksh. 0.00";

    ever(
      selectedFarmer,
      (callback) => {nameController.text = selectedFarmer.value.name},
    );

    // re-calculate daily earnings
    ever(volumeOfMilk, (callback) => calculateEarnings());
    ever(pricePerLitre, (callback) => calculateEarnings());
  }

  Future<void> saveMilkCollection() async {
    // validate inputs
    if (!formKey.currentState!.validate()) return Future.value();

    // show loading
    isLoading.value = true;

    // check if milk has been collected for this farmer
    bool isMilkCollected = await checkIfMilkCollected(
        selectedFarmer.value.id, dateController.text);
    if (isMilkCollected) {
      showErrorToast(
          "Milk for ${selectedFarmer.value.name} has already been collected for this date. ");
      isLoading.value = false;
      return;
    }

    String id = _firestore.collection("milk_collections").doc().id;
    // save to firestore
    try {
      MilkCollection newEntry = MilkCollection(
        id: id,
        farmerId: selectedFarmer.value.id,
        farmerName: selectedFarmer.value.name,
        collectionDate: dateController.text,
        volumeInLitres: double.parse(milkVolumeController.text),
        pricePerLitre: double.parse(pricePerLtrController.text),
        earnings: double.parse(milkVolumeController.text) *
            double.parse(pricePerLtrController.text),
      );

      await _firestore.collection("milk_collections").add(newEntry.toMap());
      isLoading.value = false;
      showSuccessToast("Milk collection saved successfully");
    } catch (e) {
      isLoading.value = false;
      showErrorToast(e.toString());
    }
  }

  void calculateEarnings() {
    if (volumeOfMilk.value == "" || pricePerLitre.value == "") {
      earningsController.text = "Ksh. 0.00";
      return;
    }

    double totalEarnings = (double.parse(milkVolumeController.text) *
        double.parse(pricePerLtrController.text));

    String formattedEarnings =
        NumberFormat("#,##0.00", "en_US").format(totalEarnings);
    earningsController.text = "Ksh. $formattedEarnings";
  }

  // check if farmer has milk collected for this day to avoid collecting more than once for a single farmer
  Future<bool> checkIfMilkCollected(String farmerId, String date) async {
    isLoading.value = true;
    bool isMilkCollected = false;
    try {
      await _firestore
          .collection("milk_collections")
          .where("farmerId", isEqualTo: farmerId)
          .where("collectionDate", isEqualTo: date)
          .get()
          .then((value) {
        isLoading.value = false;
        if (value.docs.isNotEmpty) {
          isMilkCollected = true;
        } else {
          isMilkCollected = false;
        }
      });
    } catch (e) {
      isLoading.value = false;
      isMilkCollected = false;
      showErrorToast(e.toString());
    }

    return isMilkCollected;
  }
}
