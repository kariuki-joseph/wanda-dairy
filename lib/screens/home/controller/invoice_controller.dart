import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wanda_dairy/models/milk_collection.dart';
import 'package:universal_html/html.dart' as html;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:wanda_dairy/models/user_model.dart';
import 'package:wanda_dairy/screens/login/controller/login_controller.dart';
import 'package:wanda_dairy/utils/pdf_invoice_api.dart';
import 'package:wanda_dairy/utils/toast_utils.dart';

class InvoiceController extends GetxController {
  final isLoading = false.obs;
  final isGeneratingPdf = false.obs;
  final milkCollections = <MilkCollection>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final loggedInUser = Rx<UserModel>(UserModel());
  final ValueNotifier<DateTime> monthYear = ValueNotifier(DateTime.now());
  late VoidCallback listener;

  final hasInvoice = false.obs;

  @override
  void onInit() async {
    super.onInit();
    // get logged in user
    loggedInUser.value = (await LoginController.getSavedUser())!;
    listener = () {
      fetchInvoice(monthYear.value);
    };
    monthYear.addListener(listener);

    // Fetch the initial month
    fetchInvoice(monthYear.value);
  }

  Future<void> generateInvoice() async {
    // check if has invoice to generate for this month
    if (!hasInvoice.value) {
      showErrorToast("No invoice to generate for this month");
      return;
    }
    isGeneratingPdf.value = true;

    // generate pdf invoice
    final pdfData = await PdfInvoiceApi.generate(
      user: loggedInUser.value,
      milkCollections: milkCollections,
      monthYear: monthYear.value,
    );

    if (kIsWeb) {
      // Web
      final blob = html.Blob([pdfData], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.window.open(url, '_blank');
      html.Url.revokeObjectUrl(url);
    } else {
      // Mobile
      final output = await getApplicationDocumentsDirectory();
      final file = File("${output.path}/invoice.pdf");
      await file.writeAsBytes(pdfData);
    }

    isGeneratingPdf.value = false;
  }

  void fetchInvoice(DateTime monthYear) async {
    isLoading.value = true;
    hasInvoice.value = false;
    final startDate = DateTime(monthYear.year, monthYear.month, 1);
    final endDate = DateTime(monthYear.year, monthYear.month + 1, 0);

    final snapshot = await _firestore
        .collection('milk_collections')
        .where('farmerId', isEqualTo: loggedInUser.value.id)
        .where('collectionDate', isGreaterThanOrEqualTo: startDate)
        .where('collectionDate', isLessThanOrEqualTo: endDate)
        .get();

    hasInvoice.value = snapshot.docs.isNotEmpty;
    milkCollections.clear();
    milkCollections.value = MilkCollection.fromQuerySnapshot(snapshot);

    isLoading.value = false;
  }

  @override
  void onClose() {
    monthYear.removeListener(listener);
    super.onClose();
  }
}
