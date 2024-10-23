import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:om/Services/api_service.dart';
import 'dart:convert';
import 'package:om/Services/shared_preferences_service.dart'; // Assuming this handles shared preferences

class ShopSalesController extends GetxController {
  // Text editing controllers
  TextEditingController shopNameController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController cashAmountController = TextEditingController();
  TextEditingController chequeAmountController = TextEditingController();
  TextEditingController onlineAmountController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  // Boolean flags for payment methods
  Rx<bool> isCash = false.obs;
  Rx<bool> isCheque = false.obs;
  Rx<bool> isOnline = false.obs;
  Rx<bool> isBalance = false.obs;
  Rx<bool> isDiscount = false.obs;

  // Observable variables for shop and results
  var selectedShop = ''.obs;
  var selectedResult = ''.obs;

  // IDs for various fields
  var assignId = 0;
  var routeId = 0;
  var employeeId = 0;
  var selectedShopId = 0;

  // Files for media
  Rx<File?> chequeImage = Rx<File?>(null);
  Rx<File?> balanceImage = Rx<File?>(null);
  Rx<File?> onlineReceipt = Rx<File?>(null);

  // Search results list
  RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;

  void fetchRequiredData() {
    assignId = sharedPrefs.getAssignId();
    routeId = sharedPrefs.getRouteId();
    employeeId = sharedPrefs.getEmpId();
  }

  // Search functionality
  Future<void> performSearch(String searchString) async {
    int routeId = sharedPrefs.getRouteId();

    try {
      searchResults.clear();
      searchResults
          .addAll(await APIService().performSearch(routeId, searchString));
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch shops: $e');
    }
  }

  void clearImages() {
    if (isCash.value) {
      isCheque.value = false;
      isOnline.value = false;
      isBalance.value = false;

      isDiscount.value = false;
      onlineAmountController.clear();
      discountController.clear();
      balanceController.clear();
      chequeAmountController.clear();
      chequeImage.value = null;
      balanceImage.value = null;
      onlineReceipt.value = null;
    } else if (isCheque.value) {
      isCash.value = false;
      isOnline.value = false;
      isBalance.value = false;

      isDiscount.value = false;

      cashAmountController.clear();
      onlineAmountController.clear();
      discountController.clear();
      balanceController.clear();
      balanceImage.value = null;
      onlineReceipt.value = null;
    } else if (isOnline.value) {
      isCash.value = false;
      isCheque.value = false;
      isBalance.value = false;

      isDiscount.value = false;

      cashAmountController.clear();
      chequeAmountController.clear();
      discountController.clear();
      balanceController.clear();
      chequeImage.value = null;
      balanceImage.value = null;
    } else if (isBalance.value) {
      isCash.value = false;
      isCheque.value = false;
      isOnline.value = false;
      isDiscount.value = false;

      onlineAmountController.clear();
      discountController.clear();
      cashAmountController.clear();
      chequeImage.value = null;
      onlineReceipt.value = null;
    } else if (isDiscount.value) {
      isCash.value = false;
      isCheque.value = false;
      isOnline.value = false;
      isBalance.value = false;

      cashAmountController.clear();
      chequeAmountController.clear();
      onlineAmountController.clear();
      balanceController.clear();
      chequeImage.value = null;
      balanceImage.value = null;
      onlineReceipt.value = null;
    }
  }

  Future<void> pickMedia() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File image = File(pickedFile.path);

      if (isCheque.value) {
        chequeImage.value = image;
      } else if (isBalance.value) {
        balanceImage.value = image;
      } else if (isOnline.value) {
        onlineReceipt.value = image;
      }

      update(); // Call update to notify listeners
    }
  }

  //convert images to base64
  String? _imageToBase64(File? image) {
    if (image == null) return null;
    return base64Encode(image.readAsBytesSync());
  }

  // Save sales info with image handling
  Future<void> saveSalesInfo() async {
    // Shop selection validation
    if (selectedShopId == 0) {
      Get.snackbar('Error', 'Please select a shop');
      return;
    }

    // Ensure only one payment method is selected
    int paymentMethodsSelected = 0;
    if (isCash.value) paymentMethodsSelected++;
    if (isCheque.value) paymentMethodsSelected++;
    if (isOnline.value) paymentMethodsSelected++;
    if (isBalance.value) paymentMethodsSelected++;
    if (paymentMethodsSelected != 1) {
      Get.snackbar('Error', 'Please select exactly one payment method');
      return;
    }

    // Validate specific fields based on the selected payment method
    if (isCash.value) {
      if (cashAmountController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter cash amount');
        return;
      }
    } else if (isCheque.value) {
      if (chequeAmountController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter cheque amount');
        return;
      }
      if (chequeImage.value == null) {
        Get.snackbar('Error', 'Please upload cheque image');
        return;
      }
    } else if (isOnline.value) {
      if (onlineAmountController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter online payment amount');
        return;
      }
      if (onlineReceipt.value == null) {
        Get.snackbar('Error', 'Please upload online payment receipt');
        return;
      }
    } else if (isBalance.value) {
      if (balanceController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter balance amount');
        return;
      }
      if (balanceImage.value == null) {
        Get.snackbar('Error', 'Please upload balance image');
        return;
      }
    }

    fetchRequiredData();
    print("Assign ID: $assignId");
    print("Route ID: $routeId");
    print("Employee ID: $employeeId");
    print("Selected Shop ID: $selectedShopId");

    // Prepare the request body with base64 encoded images
    final requestBody = {
      "assignId": {"id": assignId},
      "shopId": {"id": selectedShopId},
      "isCash": isCash.value,
      "cashAmount":
          cashAmountController.text == '' ? 0 : cashAmountController.text,
      "isOnline": isOnline.value,
      "onlineAmount":
          onlineAmountController.text == '' ? 0 : onlineAmountController.text,
      "onlinePhoto": _imageToBase64(onlineReceipt.value) ?? "string",
      "isCheck": isCheque.value,
      "checkAmount":
          chequeAmountController.text == '' ? 0 : chequeAmountController.text,
      "checkPhoto": _imageToBase64(chequeImage.value) ?? "string",
      "isBalance": isBalance.value,
      "balanceAmount":
          balanceController.text == '' ? 0 : balanceController.text,
      "balancePhoto": _imageToBase64(balanceImage.value) ?? "string",
      "isDiscount": isDiscount.value,
      "discountAmount":
          discountController.text == '' ? 0 : discountController.text,
      "createdBy": employeeId
    };

    print("Request Body: ${jsonEncode(requestBody)}");

    try {
      final response = await http.post(
        Uri.parse(
            'http://139.59.7.147:7071/driverOperations/saveShopSaleByDriver'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Sales info saved successfully!");
        Get.offAllNamed('/driverDashboard');
      } else {
        final responseBody = jsonDecode(response.body);
        Get.snackbar(
            "Error", responseBody['error'] ?? "Unknown error occurred");
        Get.offAllNamed('/driverDashboard');
      }
    } catch (e) {
      Get.snackbar("Error Here", e.toString());
    }
  }
}
