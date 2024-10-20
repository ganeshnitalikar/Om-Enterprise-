import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverExpenseController extends GetxController {
  // Text editing controllers
  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  // For handling the date input
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Method to handle date picking
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  // Method to save expense data
  void saveExpense() {
    if (selectedDate.value == null) {
      Get.snackbar('Error', 'Please select a date');
      return;
    }

    if (expenseAmountController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter an expense amount');
      return;
    }

    if (detailsController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the expense details');
      return;
    }

    // Process the data here (e.g., send to the server or save locally)
    Get.snackbar('Success', 'Expense saved successfully!');
  }
}
