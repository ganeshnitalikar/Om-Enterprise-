// import 'dart:io';
// import 'dart:html' as html; // For web file upload
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:om/Api%20Service/Admin/add_employee_service.dart';
// import 'package:universal_platform/universal_platform.dart'; // Platform check

// class AddEmployeeController extends GetxController {
//   final AddEmployeeService _employeeService = AddEmployeeService();
//   var roles = <Map<String, dynamic>>[].obs;
//   var selectedRole = ''.obs;
//   var isActive = false.obs;
//   File? selectedImage;
//   html.File? webImageFile; // For web platform image

//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final mobileNoController = TextEditingController();
//   final aadhaarNoController = TextEditingController();
//   final userNameController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchRoles();
//   }

//   // Fetch available roles from the API
//   Future<void> fetchRoles() async {
//     try {
//       roles.value = await _employeeService.fetchRoles();
//       print('Fetched roles: ${roles.value}');
//     } catch (e) {
//       print('Error fetching roles: $e');
//     }
//   }

//   // Pick an image from gallery (mobile) or file (web)
//   Future<void> pickImage() async {
//     if (UniversalPlatform.isWeb) {
//       // Web: use dart:html
//       html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//       uploadInput.accept = 'image/*';
//       uploadInput.click();
//       uploadInput.onChange.listen((e) {
//         final files = uploadInput.files;
//         if (files?.isEmpty ?? true) return;
//         webImageFile = files!.first; // Store the file for upload
//         print('Selected web image file: ${webImageFile?.name}');
//       });
//     } else if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
//       // Mobile: use ImagePicker
//       final ImagePicker _picker = ImagePicker();
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//       if (image != null) {
//         selectedImage = File(image.path);
//         print('Selected image path: ${selectedImage?.path}');
//       }
//     }
//   }

//   // Save employee data and upload the image
//   Future<void> saveEmployee() async {
//     if (selectedRole.isEmpty) {
//       Get.snackbar('Error', 'Please select a role.');
//       return;
//     }

//     final newEmployee = {
//       "roleId": {
//         "id": int.parse(selectedRole.value),
//       },
//       "firstName": firstNameController.text,
//       "lastName": lastNameController.text,
//       "mobileNo": mobileNoController.text,
//       "aadhaarNo": aadhaarNoController.text,
//       "isActive": isActive.value,
//       "createdBy": 1,
//       "updatedBy": 1,
//       "userName": userNameController.text,
//       "password": passwordController.text,
//     };

//     try {
//       print('Saving employee with data: $newEmployee');
//       // Check platform and send image appropriately
//       if (UniversalPlatform.isWeb) {
//         await _employeeService.saveEmployee(newEmployee, webImageFile: webImageFile);
//       } else {
//         await _employeeService.saveEmployee(newEmployee, imageFile: selectedImage);
//       }
//       Get.snackbar('Success', 'Employee saved successfully');
//     } catch (e) {
//       print('Error saving employee: $e');
//       Get.snackbar('Error', 'Failed to save employee');
//     }
//   }
// }
