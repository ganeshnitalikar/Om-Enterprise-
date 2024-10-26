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
    final theme = Get.theme;
    return Scaffold(
      appBar: buildAppBar(theme: theme, title: "Personal Expense"),
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
                      suffixIcon: const Icon(Icons.calendar_month),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            theme.inputDecorationTheme.border!.borderSide,
                      ),
                      hintText: 'Select Date',
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
                  OmTextField(
                      labelText: "Amount",
                      hintText: "Enter the Amount",
                      onChanged: (value) {
                        controller.amount.value = value;
                      },
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 20),

                  // Details Input Field
                  OmTextField(
                    labelText: "Details",
                    hintText: "Enter the Details",
                    onChanged: (value) {
                      controller.details.value = value;
                    },
                    keyboardType: TextInputType.text,
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
                  backgroundColor: theme.colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Add Expense",
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white, fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
