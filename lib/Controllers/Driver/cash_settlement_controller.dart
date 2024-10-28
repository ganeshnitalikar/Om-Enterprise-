import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:om/Services/shared_preferences_service.dart';

class CashSettlementController extends GetxController {
  var rs10Notes = 0.obs;
  var rs20Notes = 0.obs;
  var rs50Notes = 0.obs;
  var rs100Notes = 0.obs;
  var rs200Notes = 0.obs;
  var rs500Notes = 0.obs;
  var rs2000Notes = 0.obs;
  var coins = 0.obs;

  var totalSale = 0.0.obs;
  var totalExpense = 0.0.obs;
  var totalCash = 0.0.obs;
  var totalOnline = 0.0.obs;
  var totalBalance = 0.0.obs;
  var totalCheck = 0.0.obs;

  var totalAmount = 0.obs;

  var settlementData = {}.obs;
  Rx<bool> isLoading = false.obs;

  var baseUrl = 'http://139.59.7.147:7071';

  @override
  void onInit() async {
    await fetchSettlementDetails();
    super.onInit();
  }


  // Method to fetch settlement details
  Future<void> fetchSettlementDetails() async {
    final url =
        '$baseUrl/settlement/getSettlementDataForEmployee/${sharedPrefs.getAssignId()}';
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(url), headers: {
        'accept': '*/*',
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        // Check if response contains valid data
        if (jsonResponse['statusCode'] == 200 &&
            jsonResponse['result'] != null) {
          settlementData.value = jsonResponse['result'][0];
          // Set values from fetched data
          totalSale.value =
              double.parse(settlementData['totalsale'].replaceAll(',', ''));
          totalExpense.value =
              double.parse(settlementData['totalexpense'].replaceAll(',', ''));
          totalBalance.value =
              double.parse(settlementData['totalbalance'].replaceAll(',', ''));
          totalOnline.value =
              double.parse(settlementData['totalonline'].replaceAll(',', ''));
          totalCheck.value =
              double.parse(settlementData['totalcheck'].replaceAll(',', ''));
          update();

          print('Total Sale: ${totalSale.value}');
          print('Total Expense: ${totalExpense.value}');
          print('Total Balance: ${totalBalance.value}');
          print('Total Cash: ${totalCash.value}');
          print('Total Online: ${totalOnline.value}');
          print('Total Check: ${totalCheck.value}');

          isLoading.value = false;
        } else {
          Get.snackbar('Error', 'Failed to fetch data.');
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch data.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void calculateTotalInHandCash() {
    totalAmount.value = (rs10Notes.value * 10) +
        (rs20Notes.value * 20) +
        (rs50Notes.value * 50) +
        (rs100Notes.value * 100) +
        (rs200Notes.value * 200) +
        (rs500Notes.value * 500) +
        (rs2000Notes.value * 2000) +
        coins.value;
  }

  Future<void> saveSettlementData() async {
    final url = '$baseUrl/settlement/saveSettlementDataForEmployee';
    final headers = {
      'Content-Type': 'application/json',
      'accept': '*/*',
    };

    final body = jsonEncode({
      "assignVehicleId": {"id": 2},
      "rs10Notes": rs10Notes.value,
      "rs20Notes": rs20Notes.value,
      "rs50Notes": rs50Notes.value,
      "rs100Notes": rs100Notes.value,
      "rs200Notes": rs200Notes.value,
      "rs500Notes": rs500Notes.value,
      "rs2000Notes": rs2000Notes.value,
      "coins": coins.value,
      "totalInHandCash": totalAmount.value,
      "totalSystemCash": totalCash.value,
      "totalPersonalExpense": totalExpense.value,
      "isExpenseAmountAdd": false,
      "settlementExpense": 0,
      "createdBy": sharedPrefs.getEmpId(),
    });

    print('Request Body: $body');

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Settlement saved successfully.');
      } else {
        Get.snackbar('Error', 'Failed to save settlement.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error saving settlement: $e');
    }
  }
}
