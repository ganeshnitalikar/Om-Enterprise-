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
        backgroundColor: Colors.deepPurple,
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
                            color: Colors.black,
                          ),
                          hintText: 'Start typing to search for a shop...',
                          suffixIcon:
                              Icon(Icons.search, color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (controller.searchResults.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
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
                                  controller.searchResults.clear();
                                  controller.update();
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  )),

              const SizedBox(height: 16),

              //Discount field
              const SizedBox(height: 10),
              inputField(
                controller: controller.discountController,
                labelText: 'Discount',
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),

              // Payment Method
              const Text('Payment Method',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple)),
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
                          if (controller.isCash.value) {
                            controller.clearImages();
                          }
                          controller.update();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            color: controller.isCash.value
                                ? Colors.green.shade400
                                : Colors.deepPurple.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('Cash',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
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
      icon: const Icon(Icons.camera_alt, color: Colors.deepPurple),
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                color: isSelected.value
                    ? Colors.green.shade400
                    : Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(10),
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
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          screencontroller.pickMedia();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.camera_alt,
                              size: 30, color: Colors.deepPurple),
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
