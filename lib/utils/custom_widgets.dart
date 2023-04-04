import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar({required title, required message}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: Colors.black87,
  );
}
