import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Api%20Service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      if (response['statusCode'] == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', response['result']['userName']);
        await prefs.setInt('employeeId', response['result']['employeeId']);
        await prefs.setString('token', response['result']['token']);

        if (response['result']['employeeRole'] == 'Driver') {
          Get.offNamed('/driverDashboard', arguments: {
            'username': response['result']['userName'],
            'employeeId': response['result']['employeeId']
          });
        } else if (response['result']['employeeRole'] == 'Admin') {
          Get.offNamed('/AdminDashboard', arguments: {
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
