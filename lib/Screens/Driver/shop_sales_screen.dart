import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/shop_sales_controller.dart';
import 'package:om/utils.dart';

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
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: controller.shopNameController,
                        onChanged: (value) {
                          // Call the search function when user types
                          controller.performSearch(value);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Start typing to search for a shop...',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                      if (controller.searchResults.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.searchResults.length,
                            itemBuilder: (context, index) {
                              final shopLabel =
                                  controller.searchResults[index]['label'];
                              final shopId =
                                  controller.searchResults[index]['id'];
                              return ListTile(
                                title: Text(shopLabel),
                                onTap: () {
                                  // Set the selected shop's label and store the shopId
                                  controller.shopNameController.text =
                                      shopLabel;
                                  controller.selectedShopId = shopId;
                                  controller.searchResults
                                      .clear(); // Clear the dropdown
                                  controller.update(); // Trigger UI update
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  )),

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Cash',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Radio(
                      groupValue: controller.isCash.value,
                      value: controller.isCash.value,
                      onChanged: (value) {
                        controller.isCash = value as Rx<bool>;
                        controller.update();
                      }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 32,
                    child: TextField(
                      controller: controller.cashAmountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cash Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Cheque Payment Method
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Cheque',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 32,
                    child: TextField(
                      controller: controller.chequeAmountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cheque Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.pickChequeMedia(),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: controller.chequeImage == null
                          ? const Icon(Icons.camera_alt,
                              size: 40) // Camera icon when no image
                          : Image.file(controller.chequeImage!,
                              fit: BoxFit.cover), // Display image when selected
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Online Payment Method
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Online',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 32,
                    child: TextField(
                      controller: controller.onlineAmountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Online Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.pickOnlineMedia(),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: controller.onlineReceipt == null
                          ? const Icon(Icons.camera_alt,
                              size: 40) // Camera icon when no image
                          : Image.file(controller.onlineReceipt!,
                              fit: BoxFit.cover), // Display image when selected
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Balance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 32,
                    child: TextField(
                      controller: controller.balanceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Balance',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.pickBalanceMedia(),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: controller.balanceImage == null
                          ? const Icon(Icons.camera_alt,
                              size: 40) // Camera icon when no image
                          : Image.file(controller.balanceImage!,
                              fit: BoxFit.cover), // Display image when selected
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
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

  Widget cameraButton({required Function onPressed}) {
    return IconButton(
        onPressed: () {
          onPressed();
        },
        icon: const Icon(Icons.camera_alt));
  }
}
