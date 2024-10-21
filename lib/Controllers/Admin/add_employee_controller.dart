
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


  // Pick an image from gallery (mobile)
  Future<void> pickImage() async {
    // Mobile: use ImagePicker
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage = File(image.path);
      print('Selected image path: ${selectedImage?.path}');
    }
  }

    try {
      print('Saving employee with data: $newEmployee');
      // Save employee with the selected image
      await _employeeService.saveEmployee(newEmployee, imageFile: selectedImage);
      Get.snackbar('Success', 'Employee saved successfully');
    } catch (e) {
      print('Error saving employee: $e');
      Get.snackbar('Error', 'Failed to save employee');
    }
  }
}
