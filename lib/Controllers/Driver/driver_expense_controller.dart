import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:om/Services/shared_preferences_service.dart';
import 'dart:convert';

class DriverExpenseController extends GetxController {
  var date = ''.obs;
  var amount = ''.obs;
  var details = ''.obs;

  Future<void> submitExpense() async {
    int assignVehicleId = sharedPrefs.getAssignId();
    int createdBy = sharedPrefs.getEmpId();
    print('assignVehicleId: $assignVehicleId');
    print('createdBy: $createdBy');
    var requestBody = {
      "assignVehicleId": {"id": assignVehicleId},
      "expenseAmount": amount.value,
      "reason": details.value,
      "createdBy": createdBy
    };
    try {
      var response = await http.post(
        Uri.parse(
            'http://139.59.7.147:7071/driverOperations/saveDriverExpenseAmount'),
        headers: {
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Data saved successfully');

        // Clear the form
        date.value = '';
        amount.value = '';
        details.value = '';

        // Refresh the driver dashboard
        Get.offAllNamed('/driverDashboard');
      } else {
        Get.snackbar('Error', 'Failed to save data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save data');
    }
  }
}
