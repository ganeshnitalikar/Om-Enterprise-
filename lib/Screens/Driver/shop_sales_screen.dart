import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/shop_sales_controller.dart';
import 'package:om/Utils/utils.dart';

class ShopSalesScreen extends StatelessWidget {
  final ShopSalesController controller = Get.put(ShopSalesController());

  ShopSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Sales'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop Name Search Field
              TextField(
                controller: controller.shopNameController,
                decoration: const InputDecoration(
                  labelText: 'Shop Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Perform search on text change
                  controller.performSearch(value);

                  if (value.isEmpty) {
                    controller.selectedShop.value =
                        ''; // Clear selected shop when input is empty
                    controller.searchResults.clear(); // Clear search results
                  }
                },
              ),

              const SizedBox(height: 8), // Add some spacing

              // Dropdown for Search Results
              Obx(() {
                return DropdownButton<String>(
                  hint: const Text('Select Shop'),
                  value: controller.selectedShop.value.isNotEmpty
                      ? controller.selectedShop.value
                      : null,
                  items: controller.searchResults.map((shopName) {
                    return DropdownMenuItem<String>(
                      value: shopName,
                      child: Text(shopName),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    controller.selectedShop.value =
                        newValue ?? ''; // Assign selected shop to controller
                    controller.shopNameController.text =
                        controller.selectedShop.value; // Set the text field
                    controller.searchResults
                        .clear(); // Clear the dropdown after selection
                  },
                  isExpanded:
                      true, // Make dropdown expand to fill available space
                  underline: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                );
              }),

              const SizedBox(height: 16),

              // Total Amount Field
              TextField(
                controller: controller.totalAmountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Payment Method
              const Text('Payment Method',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Cash Payment Method
              Row(
                children: [
                  const Text('Cash',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Expanded(
                    child: TextField(
                      controller: controller.cashAmountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cash Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),

              // Cheque Payment Method
              Row(
                children: [
                  const Text('Cheque',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Expanded(
                    child: TextField(
                      controller: controller.chequeAmountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cheque Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.pickChequeMedia,
                    child: const Text('Add Cheque Photo'),
                  ),
                ],
              ),

              // Online Payment Method
              Row(
                children: [
                  const Text('Online',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Expanded(
                    child: TextField(
                      controller: controller.onlineAmountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Online Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.pickOnlineMedia,
                    child: const Text('Add Online Receipt'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Submit Button
              submitButton(
                  text: "Add Expense",
                  onPressed: () {
                    controller.saveSalesInfo();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
