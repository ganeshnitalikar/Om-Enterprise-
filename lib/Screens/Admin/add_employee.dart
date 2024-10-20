import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/add_employee_controller.dart';

class AddEmployeeScreen extends StatelessWidget {
  final AddEmployeeController controller = Get.put(AddEmployeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown to select Role
            Obx(() => DropdownButtonFormField<String>(
              hint: Text('Select Role'),
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

            // Other input fields for employee details
            TextField(
              controller: controller.firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: controller.lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: controller.mobileNoController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: controller.aadhaarNoController,
              decoration: InputDecoration(labelText: 'Aadhaar Number'),
              keyboardType: TextInputType.number,
            ),

            // Button to upload the photo
            ElevatedButton(
              onPressed: () => controller.pickImage(), // Using mobile image picker
              child: Text('Upload Photo'),
            ),

            // Checkbox to mark the employee as active
            Obx(() => CheckboxListTile(
              title: Text('Active'),
              value: controller.isActive.value,
              onChanged: (val) {
                controller.isActive.value = val ?? false;
              },
            )),

            // Username and Password fields
            TextField(
              controller: controller.userNameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true, // Password field
            ),

            // Save button
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Calls the saveEmployee method from the controller
                controller.saveEmployee();
              },
              child: Text('Save Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
