import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snackbars {
  static validationSnackbar(
      {required String header, required String body, required String type}) {
    Get.snackbar(
      header,
      body,
      icon: const Icon(Icons.error)
    );
  }
}
