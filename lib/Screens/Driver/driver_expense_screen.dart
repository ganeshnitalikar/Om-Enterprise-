import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:om/Controllers/Driver/driver_expense_controller.dart';
import 'package:om/Utils/utils.dart';

class PersonalExpenseScreen extends StatelessWidget {
  final DriverExpenseController controller = Get.put(DriverExpenseController());

  PersonalExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // DatePicker
            Obx(() {
              return Column(
                children: [
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: const OutlineInputBorder(),
                      hintText: controller.date.value.isNotEmpty
                          ? controller.date.value
                          : 'Select Date',
                      labelText: controller.date.value.isNotEmpty
                          ? controller.date.value
                          : 'Select Date',
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

                  const SizedBox(height: 16),

                  // Amount Input
                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText:
                          controller.amount.value.isEmpty ? 'Amount' : 'Amount',
                    ),
                    onChanged: (value) {
                      controller.amount.value = value;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Details Input

                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: controller.amount.value.isEmpty
                          ? 'Details'
                          : 'Details',
                    ),
                    onChanged: (value) {
                      controller.details.value = value;
                    },
                  ),
                ],
              );
            }),

            submitButton(
                text: "Add Expense",
                onPressed: () {
                  controller.submitExpense();
                })
          ],
        ),
      ),
    );
  }
}
