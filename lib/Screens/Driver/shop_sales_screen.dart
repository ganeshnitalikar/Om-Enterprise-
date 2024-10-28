import 'dart:io';

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
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: controller.shopNameController,
                        onChanged: (value) {
                          controller.performSearch(value);
                          controller.isDiscount.value = true;
                        },
                        decoration: InputDecoration(
                          labelText: 'Shop Name',
                          labelStyle: Get.theme.textTheme.labelLarge!.copyWith(
                            color: Get.theme.primaryColor,
                          ),
                          hintText: 'Start typing to search for a shop...',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          suffixIcon:
                              Icon(Icons.search, color: Get.theme.primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Get.theme.primaryColor),
                          ),
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

              // Discount Field
              inputField(
                controller: controller.discountController,
                labelText: 'Discount',
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),

              // Payment Method Title
              const Text(
                'Payment Method',
                // style: Get.theme.textTheme.headline6!
                //     .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Cash Payment Method
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.isCash.value = !controller.isCash.value;
                        if (controller.isCash.value) {
                          // controller.clearImages();
                        }
                        controller.update();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: controller.isCash.value
                              ? Colors.green
                              : Get.theme.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Cash',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (controller.isCash.value)
                      Flexible(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .5,
                          child: TextField(
                            controller: controller.cashAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Cash Amount',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(),
                  ],
                );
              }),

              const SizedBox(height: 20),

              // Cheque Payment Method
              Obx(() {
                return PaymentMethod(
                  title: 'Cheque',
                  isSelected: controller.isCheque,
                  onSelect: () {
                    controller.isCheque.value = !controller.isCheque.value;
                    controller.update();
                  },
                  amountController: controller.chequeAmountController,
                  labelText: 'Cheque Amount',
                  context: context,
                  isAmountVisible: controller.isCheque.value,
                  onPressed: () {
                    controller.pickChequeImage();
                  },
                  image:
                      controller.chequeImage.value, // Pass the selected image
                );
              }),

              const SizedBox(height: 20),

              // Online Payment Method
              Obx(() {
                return PaymentMethod(
                  title: 'Online',
                  onPressed: () {
                    controller.pickOnlineReceipt();
                  },
                  isSelected: controller.isOnline,
                  onSelect: () {
                    controller.isOnline.value = !controller.isOnline.value;
                    controller.update();
                  },
                  amountController: controller.onlineAmountController,
                  labelText: 'Online Amount',
                  context: context,
                  isAmountVisible: controller.isOnline.value,
                  image:
                      controller.onlineReceipt.value, // Pass the selected image
                );
              }),

              const SizedBox(height: 20),

              // Balance Payment Method
              Obx(() {
                return PaymentMethod(
                  title: 'Balance',
                  onPressed: () {
                    controller.pickBalanceImage();
                  },
                  isSelected: controller.isBalance,
                  onSelect: () {
                    controller.isBalance.value = !controller.isBalance.value;
                    controller.update();
                  },
                  amountController: controller.balanceController,
                  labelText: 'Balance Amount',
                  context: context,
                  isAmountVisible: controller.isBalance.value,
                  image:
                      controller.balanceImage.value, // Pass the selected image
                );
              }),
              const SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.saveSalesInfo();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Add Expense",
                      style: TextStyle(
                          color: Get.theme.primaryColorLight,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethod extends StatelessWidget {
  final String title;
  final Rx<bool> isSelected;
  final Function onSelect;
  final TextEditingController amountController;
  final String labelText;
  final BuildContext context;
  final Function onPressed;
  final bool isAmountVisible;
  final File? image; // Add the image parameter

  const PaymentMethod({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onSelect,
    required this.amountController,
    required this.labelText,
    required this.context,
    required this.isAmountVisible,
    required this.onPressed,
    this.image, // Initialize the image
  });

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
                color: isSelected.value ? Colors.green : Get.theme.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (isAmountVisible)
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .5,
                    child: TextField(
                      controller: amountController,
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
                      onPressed();
                    },
                    child: image == null
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.camera_alt, size: 40),
                          )
                        : Image.file(
                            image!,
                            height: 50,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
            )
        ],
      );
    });
  }
}
