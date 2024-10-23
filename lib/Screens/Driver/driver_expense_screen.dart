import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:om/Controllers/Driver/driver_expense_controller.dart';

class PersonalExpenseScreen extends StatelessWidget {
  final DriverExpenseController controller = Get.put(DriverExpenseController());

  PersonalExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expense'),
        backgroundColor: Colors.blue[600],
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              return Column(
                children: [
                  // Date Picker Field
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: controller.date.value.isNotEmpty
                          ? controller.date.value
                          : 'Select Date',
                      labelText: controller.date.value.isNotEmpty
                          ? controller.date.value
                          : 'Select Date',
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        controller.date.value =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Amount Input Field
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Amount',
                      hintText: 'Enter amount',
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      controller.amount.value = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Details Input Field
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Details',
                      hintText: 'Enter expense details',
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                    onChanged: (value) {
                      controller.details.value = value;
                    },
                  ),
                ],
              );
            }),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.submitExpense();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.blue[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Add Expense",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
