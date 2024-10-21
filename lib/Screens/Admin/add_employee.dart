// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:om/Controllers/Admin/add_employee_controller.dart';
import 'package:om/Utils/themes.dart';

class AddEmployeeScreen extends StatelessWidget {
  final AddEmployeeController controller = Get.put(AddEmployeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee', style: Themes.light.textTheme.displaySmall),
        backgroundColor:
            Themes.light.colorScheme.background, // AppBar color customization

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header: Personal Information
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
            ),

            // Dropdown to select Role
            Obx(() => DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Role',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: controller.selectedRole.value.isNotEmpty
                      ? controller.selectedRole.value
                      : null,
                  onChanged: (value) {
                    controller.selectedRole.value = value ?? '';
                  },
                  items: controller.roles.map((role) {
                    return DropdownMenuItem<String>(
                      value: role['id'].toString(),
                      child: Text(role['label']),
                    );
                  }).toList(),
                )),
            SizedBox(height: 20),

            // First Name and Last Name Fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller.lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Mobile Number and Aadhaar Number Fields
            TextField(
              controller: controller.mobileNoController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.aadhaarNoController,
              decoration: InputDecoration(
                labelText: 'Aadhaar Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // Photo Upload Button
            ElevatedButton.icon(
              onPressed: () => controller.pickImage(),
              icon: Icon(Icons.upload_file),
              label: Text('Upload Photo'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Section Header: Account Information
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
            ),

            // Username and Password Fields
            TextField(
              controller: controller.userNameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: true, // Password field
            ),
            SizedBox(height: 20),

            // Active Checkbox
            Obx(() => CheckboxListTile(
                  title: Text('Active'),
                  value: controller.isActive.value,
                  onChanged: (val) {
                    controller.isActive.value = val ?? false;
                  },
                  activeColor: Colors.teal,
                  controlAffinity: ListTileControlAffinity.leading,
                )),

            SizedBox(height: 30),

            // Save Button
            ElevatedButton(
              onPressed: () {
                controller.saveEmployee(); // Direct call to saveEmployee
              },
              child: Text(
                'Save Employee',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
