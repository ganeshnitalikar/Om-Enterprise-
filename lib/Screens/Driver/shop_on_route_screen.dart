import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/shop_on_route_controller.dart';
import 'package:om/Model/driver_shop_model.dart';
import 'package:om/Utils/utils.dart';

class ShopScreen extends StatelessWidget {
  final ShopOnRouteController shopController = Get.put(ShopOnRouteController());

  ShopScreen({super.key});

  void showShopDetails(BuildContext context, DriverShop shop) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(shop.shopName, style: const TextStyle(color: Colors.teal)),
          content: SingleChildScrollView(
            child: ListBody(
              mainAxis: Axis.vertical,
              children: <Widget>[
                Text('Cash: ₹${shop.cash}'),
                Text('Transaction Date: ${shop.transactionDate}'),
                Text('Online: ₹${shop.online}'),
                Text('Discount: ₹${shop.discount}'),
                Text('Check Amount: ₹${shop.checkamt}'),
                Text('Balance: ₹${shop.balance}'),
                Text('Sales ID: ${shop.salesid}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: buildAppBar(theme: theme, title: "Shops on Route"),
      body: Obx(() {
        if (shopController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (shopController.shops.isEmpty) {
          return const Center(child: Text('No shops available.'));
        }

        return ListView.builder(
          itemCount: shopController.shops.length,
          itemBuilder: (context, index) {
            final shop = shopController.shops[index];
            return GestureDetector(
              onTap: () =>
                  showShopDetails(context, shop), // Show details on tap
              child: Card(
                margin: const EdgeInsets.all(10),
                shadowColor: theme.shadowColor,
                color: theme.cardTheme.color,
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: theme.dividerColor,
                            width: 1,
                          ),
                        ),
                        color: theme.colorScheme.primary.withOpacity(0.3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            shop.shopName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            shop.transactionDate,
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 5, right: 10, left: 10, bottom: 7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cash: ₹${shop.cash}',
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontSize: 18),
                              ),
                              Text(
                                'Online: ₹${shop.online}',
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount: ₹${shop.discount}',
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontSize: 18),
                              ),
                              Text(
                                'Check Amount: ₹${shop.checkamt}',
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Balance: ₹${shop.balance}',
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontSize: 18),
                              ),
                              Text(
                                'Sales ID: ${shop.salesid}',
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
