import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Api Service/Admin/add_employee_service.dart';

class AddEmployeeController extends GetxController {
  final AddEmployeeService _employeeService = AddEmployeeService();
  var roles = <Map<String, dynamic>>[].obs;
  var selectedRole = ''.obs;
  var isActive = false.obs;
  File? selectedImage;
 // var isLoading = false.obs; 

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

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage = File(image.path);
      print('Selected image path: ${selectedImage?.path}');
    }
  }

  // Save employee data and upload the image
  Future<void> saveEmployee() async {
   //  isLoading.value = true;
    if (selectedRole.isEmpty) {
      Get.snackbar('Error', 'Please select a role.');
      return;
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
     // await Future.delayed(Duration(seconds: 2));
      // Save employee with the selected image
      await _employeeService.saveEmployee(newEmployee, imageFile: selectedImage);
      Get.snackbar('Success', 'Employee saved successfully');
    } catch (e) {
      print('Error saving employee: $e');
      Get.snackbar('Error', 'Failed to save employee');
    }
  }
}
