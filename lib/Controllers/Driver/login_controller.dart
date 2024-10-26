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

    if (username.isEmpty) {
      Get.snackbar('Error', 'Please enter username');
      return;
    } else if (password.isEmpty) {
      Get.snackbar('Error', 'Please enter password');
      return;
    } else if (username.isEmpty && password.isEmpty) {
      Get.snackbar('Error', 'Please enter username and password');
      return;
    }

    isLoading(true);

    try {
      final response = await apiService.login(username, password);

      if (response['statusCode'] == 200) {
        await sharedPrefs.setToken(response['result']['token']);
        await sharedPrefs.setEmployeeId(response['result']['employeeId']);
        await sharedPrefs.setUsername(response['result']['userName']);
        await sharedPrefs.setemployeeRole(response['result']['employeeRole']);
        print(response['result']['employeeRole']);
        print(sharedPrefs.getEmployeeRole());
        print(sharedPrefs.getToken());
        print(sharedPrefs.getEmpId());
        print(sharedPrefs.getEmployeeName());

        // Navigate based on employee role
        if (response['result']['employeeRole'] == 'Driver') {
          Get.offNamed('/driverDashboard');
        } else if (response['result']['employeeRole'] == 'Admin') {
          Get.offNamed('/adminDashboard');
        } else {
          Get.snackbar('Error', 'Invalid Employee Type');
        }

        usernameController.clear();
        passwordController.clear();
      } else {
        Get.snackbar('Login Failed', response['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
