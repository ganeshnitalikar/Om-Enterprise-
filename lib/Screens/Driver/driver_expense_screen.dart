import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/driver_expense_controller.dart';
import 'package:intl/intl.dart';

class DriverExpenseScreen extends StatelessWidget {
  final DriverExpenseController controller = Get.put(DriverExpenseController());

  DriverExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date Picker
            Obx(() => TextFormField(
                  readOnly: true,
                  onTap: () => controller.selectDate(context),
                  decoration: InputDecoration(
                    labelText: "Select Date",
                    suffixIcon: const Icon(Icons.calendar_today),
                    hintText: controller.selectedDate.value != null
                        ? DateFormat('yyyy-MM-dd')
                            .format(controller.selectedDate.value!)
                        : "Select Date",
                  ),
                )),

            const SizedBox(height: 16.0),

            // Expense Amount Input
            TextFormField(
              controller: controller.expenseAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Expense Amount",
                hintText: "Enter amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16.0),

            // Details Input
            TextFormField(
              controller: controller.detailsController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Details",
                hintText: "Enter expense details",
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(), // Push the button to the bottom

            // Save Button
            ElevatedButton(
              onPressed: controller.saveExpense,
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(double.infinity, 50), // Full-width button
              ),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
