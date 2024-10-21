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
              Obx(
                () {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.isCash.value = !controller.isCash.value;
                          // Disable other payment methods if cash is selected
                          if (controller.isCash.value) {
                            controller.clearImages();
                          }
                          controller.update();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            color: controller.isCash.value
                                ? Colors.green
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text('Cash',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      if (controller.isCash.value) ...[
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .5,
                          child: TextField(
                            controller: controller.cashAmountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Cash Amount',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              // Cheque Payment Method

              PaymentMethodWidget(
                title: 'Cheque',
                controller: controller.chequeAmountController,
                isSelected: controller.isCheque,
                onSelect: () {
                  controller.isCheque.value = !controller.isCheque.value;
                  if (controller.isCheque.value) {
                    controller.clearImages();
                  }
                  controller.update();
                },
                labelText: 'Cheque Amount',
              ),

              const SizedBox(height: 20),

// Online Payment Method
              PaymentMethodWidget(
                title: 'Online',
                controller: controller.onlineAmountController,
                isSelected: controller.isOnline,
                onSelect: () {
                  controller.isOnline.value = !controller.isOnline.value;
                  if (controller.isOnline.value) {
                    controller.clearImages();
                  }
                  controller.update();
                },
                labelText: 'Online Amount',
              ),

              const SizedBox(height: 20),

// Balance Payment Method
              PaymentMethodWidget(
                title: 'Balance',
                controller: controller.balanceController,
                isSelected: controller.isBalance,
                onSelect: () {
                  controller.isBalance.value = !controller.isBalance.value;
                  if (controller.isBalance.value) {
                    controller.clearImages();
                  }
                  controller.update();
                },
                labelText: 'Balance Amount',
              ),

              const SizedBox(height: 20),

// Discount Field
              PaymentMethodWidget(
                title: 'Discount',
                controller: controller.discountController,
                isSelected: controller.isDiscount,
                onSelect: () {
                  controller.isDiscount.value = !controller.isDiscount.value;
                  if (controller.isDiscount.value) {
                    controller.clearImages();
                  }
                  controller.update();
                },
                labelText: 'Discount Amount',
              ),

              const SizedBox(height: 30),
              // Submit Button
              submitButton(
                text: "Add Expense",
                onPressed: () {
                  controller.saveSalesInfo();
                },
              ),
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
      icon: const Icon(Icons.camera_alt),
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Rx<bool> isSelected;
  final Function onSelect;
  final String labelText;

  const PaymentMethodWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.isSelected,
    required this.onSelect,
    required this.labelText,
  });

  ShopSalesController get screencontroller => Get.find<ShopSalesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              onSelect();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: isSelected.value ? Colors.green : Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          isSelected.value
              ? Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .5,
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: labelText,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          screencontroller.pickMedia();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.camera_alt, size: 40),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      );
    });
  }
}
