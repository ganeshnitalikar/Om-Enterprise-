import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Services/api_service.dart';
import 'package:om/Services/shared_preferences_service.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final APIService apiService = APIService();

  var isLoading = false.obs;

  Future<void> login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter both username and password');
      return;
    }

    isLoading(true);

    try {
      final response = await apiService.login(username, password);
      print("here");

      if (response['statusCode'] == 200) {
        sharedPrefs.setToken(response['result']['token']);
        sharedPrefs.setEmployeeId(response['result']['employeeId']);
        sharedPrefs.setemployeeRole(response['result']['employeeRole']);

        if (response['result']['employeeRole'] == 'Driver') {
          Get.offNamed('/driverDashboard', arguments: {
            'username': response['result']['userName'],
            'employeeId': response['result']['employeeId']
          });
        } else if (response['result']['employeeRole'] == 'Admin') {

          Get.offNamed('/adminDashboard', arguments: {

            'username': response['result']['userName'],
            'employeeId': response['result']['employeeId']
          });
        } else {
          Get.snackbar('Error', 'Invalid Employee Type');
        }
      } else {
        Get.snackbar('Login Failed', response['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
