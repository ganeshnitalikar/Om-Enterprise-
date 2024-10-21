import 'package:flutter/material.dart';
import 'package:om/Screens/Admin/add_employee.dart';


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
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update Employee',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Employee Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _roleController,
                      decoration: InputDecoration(labelText: 'Role'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a role';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _contactController,
                      decoration: InputDecoration(labelText: 'Contact No'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a contact number';
                        }
                        return null;
                      },
                    ),
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
                      child: Text('Update'),
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

  // Add Employee Button - Navigate to AddEmployeeScreen
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
        title: Text('Employees'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddEmployee,
            tooltip: 'Add Employee',
          ),
        ],
      ),
      body: _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _employees.length,
              itemBuilder: (context, index) {
                final employee = _employees[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
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
    );
  }
}
