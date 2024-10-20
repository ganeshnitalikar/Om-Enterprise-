import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Services/api_service.dart';

class ExpiryMaterialController extends GetxController {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();

  // You can use the same APIService as in your ShopSalesController
  final APIService apiService = APIService();

  Future<void> saveExpiryMaterial() async {
    String shopName = shopNameController.text.trim();
    String totalAmount = totalAmountController.text.trim();

    if (shopName.isEmpty || totalAmount.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    try {
      // Assuming you're sending data to some API
      final response =
          await apiService.saveExpiryMaterial(shopName, totalAmount);

      if (response['statusCode'] == 200) {
        Get.snackbar('Success', 'Expiry material saved successfully!');
      } else {
        Get.snackbar('Error', 'Failed to save expiry material');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error saving expiry material: $e');
    }
  }
}
