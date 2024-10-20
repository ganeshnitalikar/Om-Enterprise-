import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeCard extends StatelessWidget {
  final Map employee;
  final Function refreshEmployees;

  const EmployeeCard({required this.employee, required this.refreshEmployees, Key? key}) : super(key: key);

  Future<void> deleteEmployee(int id) async {
    final response = await http.delete(
      Uri.parse('YOUR_API_URL/employees/$id'), // Update with your delete endpoint
    );

    if (response.statusCode == 200) {
      // Successfully deleted
      refreshEmployees(); // Refresh the list of employees
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Employee deleted successfully')),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Failed to delete employee')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(employee['Employee Name']),
        subtitle: Text(employee['Role']),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Handle update action
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Confirm deletion before calling deleteEmployee
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Delete Employee'),
                      content: Text('Are you sure you want to delete this employee?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            deleteEmployee(employee['Id']);
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
