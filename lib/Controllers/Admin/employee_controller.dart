import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Api Service/Admin/employee_service.dart';

class EmployeeController extends GetxController {
  final EmployeeService _employeeService = EmployeeService();
  var roles = <Map<String, dynamic>>[].obs;
  var employees = <Map<String, dynamic>>[].obs;
  var selectedRole = ''.obs;
  var isActive = false.obs;
  File? selectedImage; // Only for mobile platform

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileNoController = TextEditingController();
  final aadhaarNoController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchRoles();
  }

  // Fetch available roles from the API
  Future<void> fetchRoles() async {
    try {
      roles.value = await _employeeService.fetchRoles();
      print('Fetched roles: ${roles.value}');
    } catch (e) {
      print('Error fetching roles: $e');
    }
  }

  // Pick an image from the gallery (mobile)
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage = File(image.path);
      print('Selected image path: ${selectedImage?.path}');
    }
  }

  // Validate input fields before saving
  bool validateInputs() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        mobileNoController.text.isEmpty ||
        aadhaarNoController.text.isEmpty ||
        userNameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        selectedRole.isEmpty) {
      return false; // Validation failed
    }
    return true; // Validation passed
  }

  // Save employee data and upload the image
  Future<bool> saveEmployee() async {
    if (selectedRole.isEmpty) {
      Get.snackbar('Error', 'Please select a role.');
      return false; // Return false if no role is selected
    }

    final newEmployee = {
      "roleId": {
        "id": int.parse(selectedRole.value),
      },
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "mobileNo": mobileNoController.text,
      "aadhaarNo": aadhaarNoController.text,
      "isActive": isActive.value,
      "createdBy": 1,
      "updatedBy": 1,
      "userName": userNameController.text,
      "password": passwordController.text,
    };

    try {
      print('Saving employee with data: $newEmployee');
      await _employeeService.saveEmployee(newEmployee, selectedImage as String); // Pass only the image
      Get.snackbar('Success', 'Employee saved successfully');
      return true; // Return true on success
    } catch (e) {
      print('Error saving employee: $e');
      Get.snackbar('Error', 'Failed to save employee');
      return false; // Return false on failure
    }
  }

  // Fetch all employees
  void fetchAllEmployees() async {
    try {
      final fetchedEmployees = await _employeeService.fetchEmployees();
      employees.assignAll(fetchedEmployees); // Update the observable list
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }
}
