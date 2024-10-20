import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopSalesController extends GetxController {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController cashAmountController = TextEditingController();
  TextEditingController chequeAmountController = TextEditingController();
  TextEditingController onlineAmountController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  var selectedShop = ''.obs; 

  File? chequeImage;
  File? onlineReceipt;
  RxList<String> searchResults = <String>[].obs;
  String routeId =
      "2"; // hardcoded routeId, replace with actual routeId if necessary

  // Search functionality
  Future<void> performSearch(String searchString) async {
    const int routeId = 2; // Replace with the actual routeId if necessary
    final String url =
        'http://139.59.7.147:7071/driverOperations/getShopAutoComplete/$routeId/$searchString';

    try {
      // Clear previous search results
      searchResults.clear();

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['statusCode'] == 200) {
          // Extract and add the labels to the searchResults list
          for (var shop in data['result']) {
            searchResults.add(shop['label']);
          }
        } else {
          // Handle case where no data is found
          searchResults.clear(); // Clear search results if no data
        }
      } else {
        // Handle error responses from the server
        searchResults.clear(); // Clear search results on error
        print(
            'Error: Server responded with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      searchResults.clear(); // Clear search results on error
      print('Error fetching shops: $e');
      // Optionally show a user-friendly message or snackbar
      Get.snackbar('Error', 'Failed to fetch shops. Please try again.');
    }
  }

  
  Future<void> pickChequeMedia() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      chequeImage = File(pickedFile.path);
      update(); // Updates the UI if required
    }
  }

  
  Future<void> pickOnlineMedia() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      onlineReceipt = File(pickedFile.path);
      update(); // Updates the UI if required
    }
  }

  
  Future<void> saveSalesInfo() async {
    // Prepare the request body
    final requestBody = {
      "assignVehicleId": {
        "id": 0,
        "employeeId": {
          "createdBy": 2,
          "lastModifiedBy": 2,
          "id": 0,
          "roleId": {
            "createdBy": 0,
            "lastModifiedBy": 0,
            "id": 0,
            "role": "driver",
            "isActive": true,
            "isDelete": true
          },
          "firstName": "John",
          "lastName": "Doe",
          "mobileNo": "1234567890",
          "aadhaarNo": "1234-5678-9123",
          "photoPath": "path/to/photo",
          "userName": "johndoe",
          "password": "password",
          "isActive": true,
          "isDelete": true
        },
        "vehicleId": {
          "createdBy": 0,
          "lastModifiedBy": 0,
          "id": 0,
          "vehicleNo": "XYZ123",
          "isActive": true,
          "isDelete": true
        },
        "routeId": {
          "createdBy": 0,
          "lastModifiedBy": 0,
          "id": 0,
          "routeName": "Route A",
          "isActive": true,
          "isDelete": true
        },
        "assignById": {
          "createdBy": 0,
          "lastModifiedBy": 0,
          "id": 0,
          "roleId": {
            "createdBy": 0,
            "lastModifiedBy": 0,
            "id": 0,
            "role": "string",
            "isActive": true,
            "isDelete": true
          },
          "firstName": "Jane",
          "lastName": "Smith",
          "mobileNo": "0987654321",
          "aadhaarNo": "1234-5678-9124",
          "photoPath": "path/to/photo",
          "userName": "janesmith",
          "password": "password",
          "isActive": true,
          "isDelete": true
        },
        "assignDateTime": DateTime.now().toIso8601String(), // Use current time
        "isComplete": true,
        "totalMaterial": 0,
        "totalSale": 0,
        "returnInVehicle": 0,
        "totalExpense": 0,
        "totalDiscount": 0,
        "extraProfitAmount": 0
      },
      "expenseAmount": double.tryParse(totalAmountController.text) ?? 0,
      "reason": "Expense reason here",
      "createdBy": 0 // Provide the creator's ID
    };

    // Execute the POST request
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

      // Check response status
      if (response.statusCode == 200) {
        // Handle success
        Get.snackbar("Success", "Sales info saved successfully!");
      } else {
        // Handle error
        final responseBody = jsonDecode(response.body);
        Get.snackbar(
            "Error", responseBody['error'] ?? "Unknown error occurred");
      }
    } catch (e) {
      // Handle exceptions (e.g., network issues)
      Get.snackbar("Error", e.toString());
    }
  }
}
