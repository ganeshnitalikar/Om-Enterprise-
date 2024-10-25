import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:om/Api%20Service/Admin/Api.dart';


class AddEmployeeController extends GetxController {
  final api=new ApiClass();
  var roles = <Map<String, dynamic>>[].obs;
  var selectedRole = ''.obs;
  var isActive = false.obs;
  File? selectedImage;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileNoController = TextEditingController();
  final aadhaarNoController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchRoles(); // Fetch roles when the controller is initialized
  }

  // Fetch roles from the service and update the roles list
  Future<void> fetchRoles() async {
    try {
      final roleData = await api.fetchRoles();
      roles.assignAll(roleData);
      if (roles.isNotEmpty) {
        selectedRole.value = roles[0]['id'].toString(); // Set default selection if roles are fetched
      }
    } catch (e) {
      print('Error fetching roles: $e');
      Get.snackbar('Error', 'Failed to load roles');
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
      await api.saveEmployee(newEmployee, imageFile: selectedImage);
      Get.snackbar('Success', 'Employee saved successfully');
    } catch (e) {
      print('Error saving employee: $e');
      Get.snackbar('Error', 'Failed to save employee');
    }
  }
}
