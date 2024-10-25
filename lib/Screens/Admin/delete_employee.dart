import 'package:flutter/material.dart';
import 'package:om/Api%20Service/Admin/Api.dart';

class EmployeeCard extends StatelessWidget {
   final api=new ApiClass();
  final Map employee;
  final Function refreshEmployees;

  EmployeeCard({
    required this.employee,
    required this.refreshEmployees,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(employee['Employee Name']),
        subtitle: Text(employee['Role']),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Edit Button (implement navigation to edit screen later)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Handle update action
              },
            ),
            // Delete Button
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
                          onPressed: () async {
                            bool success = await api.deleteEmployee(employee['Id']);
                            if (success) {
                              refreshEmployees(); // Refresh the list of employees
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Employee deleted successfully')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to delete employee')),
                              );
                            }
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
