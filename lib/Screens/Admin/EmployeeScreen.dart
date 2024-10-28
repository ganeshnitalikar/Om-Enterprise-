import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:om/Controllers/Admin/employee_controller.dart';
import 'package:om/Screens/Admin/add_employee.dart';
import 'package:om/Services/api_service.dart';

class EmployeeScreen extends StatelessWidget {
  final EmployeeController employeeController = Get.put(EmployeeController());

  void _showUpdateBottomSheet(
      BuildContext context, Map<String, dynamic> employee) {
    final _formKey = GlobalKey<FormState>();
    final controllers = {
      'Employee Name': TextEditingController(text: employee['Employee Name']),
      'Role': TextEditingController(text: employee['Role']),
      'Contact No': TextEditingController(text: employee['Contact No']),
    };

    Get.bottomSheet(
      Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.orange),
        child: Material(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: Container(
            color: const Color.fromARGB(255, 196, 216, 233),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  Text('Update Employee',
                      style: TextStyle(color: Colors.black)),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ...controllers.entries
                            .map((entry) =>
                                _buildTextField(entry.value, entry.key))
                            .toList(),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              employeeController.updateEmployee(
                                employee['Id'],
                                controllers['Employee Name']!.text,
                                controllers['Role']!.text,
                                controllers['Contact No']!.text,
                              );
                              Get.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text('Update', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) => value!.isEmpty ? 'Please enter $labelText' : null,
      ),
    );
  }

  void _showDeleteConfirmationDialog(int employeeId) {
    Get.defaultDialog(
      title: "Confirm Delete",
      content: Text("Are you sure you want to delete this employee?"),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () => Get.back(),
        ),
        TextButton(
          child: Text("Delete", style: TextStyle(color: Colors.red)),
          onPressed: () {
            employeeController.deleteEmployee(employeeId);
            Get.back();
          },
        ),
      ],
    );
  }

  void _navigateToAddEmployee() {
    Get.to(() => AddEmployeeScreen());
  }

  Widget _buildEmployeeCard(Map<String, dynamic> employee) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          employee['Employee Name'],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Role: ${employee['Role']}'),
            Text('Contact: ${employee['Contact No']}'),
            Text('Status: ${employee['Status'] ? 'Active' : 'Inactive'}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _showUpdateBottomSheet(Get.context!, employee),
              tooltip: 'Update',
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteConfirmationDialog(employee['Id']),
              tooltip: 'Delete',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employees',
          style: GoogleFonts.roboto(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 117, 183, 241),
        actions: [  
       
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddEmployee,
            tooltip: 'Add Employee',
          ),
           const SizedBox(
            width: 10,
          ),
         IconButton(
        icon: Icon(
          Icons.logout,
          color: theme.iconTheme.color,
        ),
        onPressed: () {
          Get.dialog(Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Are you sure you want to logout?",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          APIService().logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.error,
                        ),
                        child: Text("Yes",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: theme.canvasColor)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: theme.elevatedButtonTheme.style,
                        child: Text(
                          "No",
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
        },
      ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          if (employeeController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (employeeController.errorMessage.isNotEmpty) {
            return Center(
                child: Text(employeeController.errorMessage.value,
                    style: TextStyle(color: Colors.red)));
          } else if (employeeController.employees.isEmpty) {
            return Center(child: Text("No employees found."));
          } else {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              itemCount: employeeController.employees.length,
              itemBuilder: (context, index) =>
                  _buildEmployeeCard(employeeController.employees[index]),
            );
          }
        }),
      ),
    );
  }
}
