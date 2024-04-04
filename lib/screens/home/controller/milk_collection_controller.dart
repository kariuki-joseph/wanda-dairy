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
  final Rx<UserModel?> selectedFarmer = Rx<UserModel?>(null);
  // track loading state
  final isLoading = false.obs;
  final isUpdatingMilkPrice = false.obs;
  // auto re-calculate daily earnings
  final dailyMilkVol = 0.0.obs;

  final pricePerLitre = 1.0.obs;
  // daily milk collection overview
  final dailyCollectedLitres = 0.0.obs;

  final mainCategory = "".obs;

  final selectedDate = DateTime.now().obs;

  // user input controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController milkVolumeController = TextEditingController();
  final TextEditingController pricePerLtrController = TextEditingController();
  final TextEditingController earningsController = TextEditingController();
  // form key for form validations
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updatePriceFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getPricePerLitre();

    // set default form field values
    dateController.text = DateFormat("dd/MM/yyyy").format(selectedDate.value);
    earningsController.text = "Ksh. 0.00";

    // listeners
    ever(
      selectedFarmer,
      (callback) => {nameController.text = selectedFarmer.value?.name ?? ""},
    );
    // re-calculate daily earnings
    ever(dailyMilkVol, (callback) => calculateEarnings());
    ever(pricePerLitre, (callback) => calculateEarnings());

    // calculate total milk delivered today whenever a new milk collection is added
    ever(milkCollections, (callback) {
      debugPrint("Milk collection changed ${milkCollections.length}");

      // calculate milk collected today
      for (var collection in milkCollections) {
        if (DateFormat("dd/MM/yyyy").format(collection.collectionDate) ==
            DateFormat("dd/MM/yyyy").format(DateTime.now())) {
          dailyCollectedLitres.value += collection.volumeInLitres;
        }
      }
    });

    // fetch milk collection summary from firebase
    fetchMilkCollectionSummary();
  }

  Future<void> saveMilkCollection() async {
    // validate inputs
    if (!formKey.currentState!.validate()) return Future.value();
    if (selectedFarmer.value == null) return Future.value();

    // show loading
    isLoading.value = true;

    String id = _firestore.collection("milk_collections").doc().id;
    // save to firestore
    try {
      MilkCollection newEntry = MilkCollection(
        id: id,
        farmerId: selectedFarmer.value!.id,
        farmerName: selectedFarmer.value!.name,
        phone: selectedFarmer.value!.phone,
        collectionDate: DateFormat("dd/MM/yyyy").parse(dateController.text),
        volumeInLitres: double.parse(milkVolumeController.text),
        pricePerLitre: double.parse(pricePerLtrController.text),
      );

      await _firestore.collection("milk_collections").add(newEntry.toMap());
      // add to milk collections
      milkCollections.add(newEntry);
      isLoading.value = false;
      showSuccessToast("Milk collection saved successfully");
      // reset form fields
      selectedFarmer.value = null;
      milkVolumeController.text = "";
      earningsController.text = "Ksh. 0.0";
    } catch (e) {
      isLoading.value = false;
      showErrorToast(e.toString());
    }
  }

  void calculateEarnings() {
    if (dailyMilkVol.value == 0 || pricePerLitre.value == 0) {
      earningsController.text = "Ksh. 0.0";
      return;
    }
    double totalEarnings =
        (double.parse(milkVolumeController.text) * pricePerLitre.value);

    earningsController.text =
        "Ksh. ${NumberFormat("#,##0.00", "en_US").format(totalEarnings)}";
  }

  // get today's milk collection summry
  Future<void> fetchMilkCollectionSummary() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection("milk_collections").get();
      if (querySnapshot.docs.isNotEmpty) {
        milkCollections.value = MilkCollection.fromQuerySnapshot(querySnapshot);
      }
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  // update the price per litre
  Future<void> updatePricePerLitre() async {
    if (!updatePriceFormKey.currentState!.validate()) return;

    isUpdatingMilkPrice.value = true;

    pricePerLitre.value = double.parse(pricePerLtrController.text);
    // save to firebase
    await _firestore
        .collection("price_per_litre")
        .doc(DateFormat("dd/MM/yyyy").format(DateTime.now()))
        .set(
      {
        "price": double.parse(pricePerLtrController.text),
      },
    );

    isUpdatingMilkPrice.value = false;

    showSuccessToast("Price Per Litre updated successfully");
  }

  // get price per litre from firebase
  void getPricePerLitre() async {
    try {
      await _firestore.collection("settings").doc("price_per_litre").get().then(
        (value) {
          if (value.exists) {
            double price = double.parse(value.data()!["price"].toString());
            pricePerLitre.value = price;
            pricePerLtrController.text = price.toString();
          }
        },
      );
    } catch (e) {
      showErrorToast(e.toString());
    }
  }
}
