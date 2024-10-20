import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:om/Controllers/Driver/driver_expense_controller.dart';

class DriverExpenseScreen extends StatelessWidget {
  final DriverExpenseController controller = Get.put(DriverExpenseController());

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

            SizedBox(height: 16.0),

            // Expense Amount Input
            TextFormField(
              controller: controller.expenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Expense Amount",
                hintText: "Enter amount",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16.0),

            // Details Input
            TextFormField(
              controller: controller.detailsController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Details",
                hintText: "Enter expense details",
                border: OutlineInputBorder(),
              ),
            ),

            Spacer(), // Push the button to the bottom

            // Save Button
            ElevatedButton(
              onPressed: controller.saveExpense,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
              ),
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
