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
  bool isCheque = false;
  bool isOnline = false;
  bool isBalance = false;
  bool isDiscount = false;

  // Observable variables for shop and results
  var selectedShop = ''.obs;
  var selectedResult = ''.obs;

  // IDs for various fields
  var assignId = 0;
  var routeId = 0;
  var employeeId = 0;
  var selectedShopId = 0;

  // Files for media
  File? chequeImage;
  File? balanceImage;
  File? onlineReceipt;

  // Search results list
  RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;

  // Search functionality
  Future<void> performSearch(String searchString) async {
    int routeId =
        sharedPrefs.getRouteId(); // Assuming sharedPrefs gives you this

    try {
      searchResults.clear();
      searchResults
          .addAll(await APIService().performSearch(routeId, searchString));
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch shops: $e');
    }
  }

  // Image pickers for various media types
  Future<void> pickChequeMedia() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      chequeImage = File(pickedFile.path);
      update();
    }
  }

  Future<void> pickBalanceMedia() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      balanceImage = File(pickedFile.path); // Correcting this line
      update();
    }
  }

  Future<void> pickOnlineMedia() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      onlineReceipt = File(pickedFile.path);
      update();
    }
  }

  // Helper method to convert images to base64
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
    if (isCheque) paymentMethodsSelected++;
    if (isOnline) paymentMethodsSelected++;
    if (isBalance) paymentMethodsSelected++;
    print(paymentMethodsSelected);
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
    } else if (isCheque) {
      if (chequeAmountController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter cheque amount');
        return;
      }
      if (chequeImage == null) {
        Get.snackbar('Error', 'Please upload cheque image');
        return;
      }
    } else if (isOnline) {
      if (onlineAmountController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter online payment amount');
        return;
      }
      if (onlineReceipt == null) {
        Get.snackbar('Error', 'Please upload online payment receipt');
        return;
      }
    } else if (isBalance) {
      if (balanceController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter balance amount');
        return;
      }
      if (balanceImage == null) {
        Get.snackbar('Error', 'Please upload balance image');
        return;
      }
    }

    // Prepare the request body with base64 encoded images
    final requestBody = {
      "assignId": {"id": assignId},
      "shopId": {"id": selectedShopId},
      "isCash": isCash,
      "cashAmount": cashAmountController.text,
      "isOnline": isOnline,
      "onlineAmount": onlineAmountController.text,
      "onlinePhoto": _imageToBase64(onlineReceipt) ?? "string",
      "isCheck": isCheque,
      "checkAmount": chequeAmountController.text,
      "checkPhoto": _imageToBase64(chequeImage) ?? "string",
      "isBalance": isBalance,
      "balanceAmount": balanceController.text,
      "balancePhoto": _imageToBase64(balanceImage) ?? "string",
      "isDiscount": isDiscount,
      "discountAmount": discountController.text,
      "createdBy": 2
    };

    try {
      final response = await http.post(
        Uri.parse(
            'http://139.59.7.147:7071/driverOperations/saveDriverExpenseAmount'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Sales info saved successfully!");
      } else {
        final responseBody = jsonDecode(response.body);
        Get.snackbar(
            "Error", responseBody['error'] ?? "Unknown error occurred");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
