import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorToast(String message) => Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );

void showSuccessToast(String message) => Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
