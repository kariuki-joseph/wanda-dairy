import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/models/milk_collection.dart';
import 'package:wanda_dairy/models/payment_model.dart';
import 'package:wanda_dairy/screens/home/controller/milk_collection_controller.dart';
import 'package:wanda_dairy/utils/toast_utils.dart';

class PaymentsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final MilkCollectionController milkCollectionController =
      Get.find<MilkCollectionController>();
  // total amount that has been paid per farmer
  final Rx<Map<String, double>> amtDue = Rx<Map<String, double>>({});
  // total amount that has been earned per farmer
  final Rx<Map<String, double>> totalAmt = Rx<Map<String, double>>({});

  // total amount of milk collected per farmer
  final Rx<Set<MilkCollection>> milkCollections = Rx<Set<MilkCollection>>({});

  final RxSet<String> isLoading = RxSet<String>();

  @override
  onInit() async {
    super.onInit();
    getMilkCollectionInfo();

    ever(milkCollectionController.milkCollections, (_) {
      getMilkCollectionInfo();
    });
  }

  // get the total amount of milk collected per farmer
  void getMilkCollectionInfo() async {
    // reset total and due amount
    totalAmt.value = {};
    amtDue.value = {};

    for (var collection in milkCollectionController.milkCollections) {
      // set only stores unique items
      milkCollections.value.add(collection);

      double amt = collection.volumeInLitres * collection.pricePerLitre;

      // check total amount
      if (totalAmt.value.containsKey(collection.farmerId)) {
        totalAmt.value[collection.farmerId] =
            totalAmt.value[collection.farmerId]! + amt;
      } else {
        totalAmt.value[collection.farmerId] = amt;
      }

      // check due(unpaid) amount
      if (amtDue.value.containsKey(collection.farmerId)) {
        amtDue.value[collection.farmerId] = amtDue.value[collection.farmerId]! +
            (collection.isPaid ? 0.0 : amt);
      } else {
        amtDue.value[collection.farmerId] = (collection.isPaid) ? 0.0 : amt;
      }
    }
  }

  void payFarmer(MilkCollection milkCollectionOwner) async {
    // check if there is any amount left to pay
    if (amtDue.value[milkCollectionOwner.farmerId] == 0.0) {
      showErrorToast("The farmer has been fully paid");
      return;
    }

    PaymentModel payment = PaymentModel(
      farmerId: milkCollectionOwner.farmerId,
      amount: totalAmt.value[milkCollectionOwner.farmerId]! -
          (amtDue.value[milkCollectionOwner.farmerId] ?? 0),
      paymentDate: DateTime.now(),
      farmerName: milkCollectionOwner.farmerName,
    );

    isLoading.add(milkCollectionOwner.farmerId);

    try {
      await _firestore.collection("payments").add(payment.toMap());

      // update the milk collection to reflect that the farmer has been paid
      QuerySnapshot snapshot = await _firestore
          .collection("milk_collections")
          .where("farmerId", isEqualTo: milkCollectionOwner.farmerId)
          .get();

      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.update({"isPaid": true});
      }
      // get updated milk collection info
      await milkCollectionController.fetchMilkCollectionSummary();

      showSuccessToast("Payment made successfully");
    } catch (e) {
      showErrorToast(
        "An error occurred while trying to pay the farmer: ${e.toString()}",
      );
    } finally {
      isLoading.remove(milkCollectionOwner.farmerId);
    }
  }
}
