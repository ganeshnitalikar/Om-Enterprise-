<<<<<<< HEAD
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:om/Screens/Admin/add_employee.dart';
import 'package:om/Utils/themes.dart';


=======

import 'package:flutter/material.dart';
import 'package:om/Screens/Admin/add_employee.dart';
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5
import '../../Api Service/Admin/employee_service.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}


class _EmployeeScreenState extends State<EmployeeScreen> {
  final EmployeeService _employeeService = EmployeeService();
  List<Map<String, dynamic>> _employees = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    try {
      final employees = await _employeeService.fetchEmployees();
      setState(() {
        _employees = employees;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching employees: $e';
      });
    }
  }

  void _showUpdateBottomSheet(Map<String, dynamic> employee) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: employee['Employee Name']);
    final _roleController = TextEditingController(text: employee['Role']);
    final _contactController = TextEditingController(text: employee['Contact No']);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                'Update Employee',
<<<<<<< HEAD
                style: Themes.light.textTheme.headlineMedium,
=======
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_nameController, 'Employee Name'),
                    _buildTextField(_roleController, 'Role'),
                    _buildTextField(_contactController, 'Contact No'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _updateEmployee(
                            employee['Id'],
                            _nameController.text,
                            _roleController.text,
                            _contactController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Update', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _updateEmployee(int employeeId, String name, String role, String contact) async {
    try {
      final response = await _employeeService.updateEmployee(employeeId, name, role, contact);
      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Employee updated successfully!')));
        _fetchEmployees(); // Refresh the employee list after successful update
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update failed: ${response['message']}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating employee: $e')));
    }
  }

  Future<void> _deleteEmployee(int employeeId) async {
    try {
      await _employeeService.deleteEmployee(employeeId); // Call delete API
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Employee deleted successfully!')));
      _fetchEmployees(); // Refresh the employee list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting employee: $e')));
    }
  }

  void _showDeleteConfirmationDialog(int employeeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this employee?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                _deleteEmployee(employeeId); // Proceed with deletion
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToAddEmployee() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEmployeeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text('Employees',style: Themes.light.textTheme.headlineSmall,),
        backgroundColor: Themes.light.colorScheme.background,
        actions: [
=======
        title: Text('Employees'),
          actions: [
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddEmployee,
            tooltip: 'Add Employee',
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0), // Add padding for the main body
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _errorMessage.isNotEmpty
            ? Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red)))
            : _employees.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: _employees.length,
                    itemBuilder: (context, index) {
                      final employee = _employees[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          title: Text(
                            employee['Employee Name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
                                onPressed: () => _showUpdateBottomSheet(employee),
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
                    },
                  ),
      ),
    );
  }
}
