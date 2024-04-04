import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wanda_dairy/models/milk_collection.dart';
import 'package:wanda_dairy/models/user_model.dart';
import 'package:wanda_dairy/screens/login/controller/login_controller.dart';
import 'package:wanda_dairy/utils/toast_utils.dart';

//
class FarmerController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final loggedInUser = Rx<UserModel>(UserModel());

  // store milk collections for this user
  final RxList<MilkCollection> milkCollections = <MilkCollection>[].obs;
  // store the days the user has made milk collections
  final RxSet<String> collectionDates = <String>{}.obs;
  // store the total milk collected in each day
  final RxMap<String, double> totalVolume = <String, double>{}.obs;
  // store price per litre for each day

  Future<void> getSummary() async {}
  final viewModeObs = ViewMode.daily.obs;

  final dailyVolume = 0.0.obs;
  final dailyPricePerLitre = 0.0.obs;
  final dailyEarnings = 0.0.obs;

  final weeklyVolume = 0.0.obs;
  final weeklyPricePerLitre = 0.0.obs;
  final weeklyEarnings = 0.0.obs;

  final monthlyVolume = 0.0.obs;
  final monthlyPricePerLitre = 0.0.obs;
  final monthlyEarnings = 0.0.obs;

  final RxMap<String, double> pricePerLitre = <String, double>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    // get logged in user
    loggedInUser.value = (await LoginController.getSavedUser())!;
    getMilkCollectionSummary();

    // observe milk collections to calculate daily, weekly and monthly summaries
    ever(milkCollections, (callback) {
      for (MilkCollection collection in milkCollections) {
        DateTime now = DateTime.now();
        DateTime collectionDate = collection.collectionDate;
        String collectionDateStr =
            DateFormat("dd/MM/yyyy").format(collectionDate);
        // set the days milk was collected
        collectionDates.add(collectionDateStr);

        // calculate volume of milk collected for each day(RxMap)
        if (totalVolume.containsKey(collectionDateStr)) {
          totalVolume[collectionDateStr] =
              totalVolume[collectionDateStr]! + collection.volumeInLitres;
        } else {
          totalVolume[collectionDateStr] = collection.volumeInLitres;
        }
        // calculate daily summary
        if (collectionDateStr == DateFormat("dd/MM/yyyy").format(now)) {
          dailyVolume.value += collection.volumeInLitres;
          dailyPricePerLitre.value = collection.pricePerLitre;
          dailyEarnings.value +=
              collection.volumeInLitres * collection.pricePerLitre;
        }

        // calculate weekly summary
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday));
        DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
        if (collectionDate.isAtSameMomentAs(startOfWeek) ||
            collectionDate.isAfter(startOfWeek) &&
                collectionDate
                    .isBefore(endOfWeek.add(const Duration(days: 1)))) {
          weeklyVolume.value += collection.volumeInLitres;
          weeklyPricePerLitre.value = collection.pricePerLitre;
          weeklyEarnings.value +=
              collection.volumeInLitres * collection.pricePerLitre;
        }

        // calculate monthly summary
        DateTime startOfMonth = DateTime(now.year, now.month, 1);
        DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);
        if ((collectionDate.isAtSameMomentAs(startOfMonth) ||
                collectionDate.isAfter(startOfMonth)) &&
            collectionDate.isBefore(endOfMonth.add(const Duration(days: 1)))) {
          monthlyVolume.value += collection.volumeInLitres;
          monthlyPricePerLitre.value = collection.pricePerLitre;
          monthlyEarnings.value +=
              collection.volumeInLitres * collection.pricePerLitre;
        }
      }
    });

    // get price per litre
    await fetchPricePerLitre();
  }

  Future<void> getMilkCollectionSummary() async {
    try {
      QuerySnapshot querySnapshot = await _fireStore
          .collection("milk_collections")
          .where("farmerId", isEqualTo: loggedInUser.value.id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        milkCollections.value = MilkCollection.fromQuerySnapshot(querySnapshot);
      }
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  void getDailySummary(DateTime selectedDay) {
    dailyVolume.value = 0.0;
    dailyPricePerLitre.value = 0.0;
    dailyEarnings.value = 0.0;

    for (MilkCollection collection in milkCollections) {
      if (collection.collectionDate.year == selectedDay.year &&
          collection.collectionDate.month == selectedDay.month &&
          collection.collectionDate.day == selectedDay.day) {
        dailyVolume.value += collection.volumeInLitres;
        dailyPricePerLitre.value = collection.pricePerLitre;
        dailyEarnings.value +=
            collection.volumeInLitres * collection.pricePerLitre;
      }
    }
  }

  void getWeeklySummary(DateTime selectedDay) {
    weeklyVolume.value = 0.0;
    weeklyPricePerLitre.value = 0.0;
    weeklyEarnings.value = 0.0;

    DateTime startOfWeek =
        selectedDay.subtract(Duration(days: selectedDay.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    for (MilkCollection collection in milkCollections) {
      DateTime collectionDate = collection.collectionDate;

      if (collectionDate.isAfter(startOfWeek) &&
          collectionDate.isBefore(endOfWeek.add(const Duration(days: 1)))) {
        weeklyPricePerLitre.value = collection.pricePerLitre;
        weeklyEarnings.value +=
            collection.volumeInLitres * collection.pricePerLitre;
      }
    }

    weeklyVolume.value =
        totalVolume[DateFormat("dd/MM/yyyy").format(selectedDay)] ?? 0.0;
  }

  void getMonthlySummary(DateTime selectedDay) {
    monthlyVolume.value = 0.0;
    monthlyPricePerLitre.value = 0.0;
    monthlyEarnings.value = 0.0;

    DateTime startOfMonth = DateTime(selectedDay.year, selectedDay.month, 1);
    DateTime endOfMonth = DateTime(selectedDay.year, selectedDay.month + 1, 0);

    for (MilkCollection collection in milkCollections) {
      DateTime collectionDate = collection.collectionDate;

      if (collectionDate.isAfter(startOfMonth) &&
          collectionDate.isBefore(endOfMonth.add(const Duration(days: 1)))) {
        monthlyPricePerLitre.value = collection.pricePerLitre;
        monthlyEarnings.value +=
            collection.volumeInLitres * collection.pricePerLitre;
      }
    }

    // get milk collected for the selected day
    monthlyVolume.value =
        totalVolume[DateFormat("dd/MM/yyyy").format(selectedDay)] ?? 0.0;
  }

  double getPricePerLtrForDate(DateTime day) {
    for (var collection in milkCollections) {
      if (DateFormat("dd/MM/yyyy").format(collection.collectionDate) ==
          DateFormat("dd/MM/yyyy").format(day)) {
        return collection.pricePerLitre;
      }
    }

    return 0.0;
  }

  Future<void> fetchPricePerLitre() async {
    QuerySnapshot snapshot =
        await _fireStore.collection("price_per_litre").get();
    if (snapshot.docs.isNotEmpty) {
      // set price per litre
      pricePerLitre.value = {for (var e in snapshot.docs) e.id: e["price"]};
    }
  }
}

enum ViewMode { daily, monthly }
