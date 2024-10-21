import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Services/api_service.dart';
import 'package:om/Controllers/Driver/driver_dashboard_controller.dart';
import 'package:om/Services/shared_preferences_service.dart';

class DriverDashboard extends StatelessWidget {
  final DriverDashboardController controller =
      Get.put(DriverDashboardController());
  final String username = sharedPrefs.getusername();

  DriverDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.onBackground,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.primary,
              ),
              child: Text('Menu',
                  style: Get.theme.textTheme.headlineLarge!
                      .copyWith(color: Get.theme.colorScheme.onPrimary)),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: Text('Dashboard',
                  style: Get.theme.textTheme.bodyLarge!
                      .copyWith(color: Get.theme.colorScheme.tertiary)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Shop Sales'),
              onTap: () {
                if (controller.assignId.value != 0 &&
                    controller.routeId.value != 0) {
                  Get.toNamed('/driverShopSales');
                } else {
                  Get.snackbar("Error", "Route not assigned");
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.money_off),
              title: const Text('Expiry Settlement'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.sms_failed),
              title: const Text('Expense Module'),
              onTap: () {
                Get.toNamed('/driverExpense');
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report'),
              onTap: () {
                Get.toNamed('/driverReport');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Get.snackbar(
                    "Confirm Logout", "Are You Sure You Want To Logout?",
                    snackPosition: SnackPosition.TOP,
                    margin: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    colorText: Colors.black,
                    duration: const Duration(seconds: 5),
                    mainButton: TextButton(
                      onPressed: () {
                        APIService().logout();
                        Get.offAllNamed('/login');
                        Get.back();
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.red),
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Welcome,", style: TextStyle(fontSize: 22)),
                        Text(sharedPrefs.getEmployeeName(),
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Route Name: ",
                          style: TextStyle(fontSize: 22),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          softWrap: true,
                          controller.routeName.value,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardCard(
                      title: 'Total Sale', value: controller.totalSale.value),
                  DashboardCard(
                      title: "Total Material",
                      value: controller.totalMaterial.value),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardCard(
                      title: 'Total Expense',
                      value: controller.totalExpense.value),
                  DashboardCard(
                      title: 'Current In Vehicle',
                      value: controller.currentInVehicle.value),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardCard(
                      title: 'Total Discount',
                      value: controller.totalDiscount.value),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final double value;

  DashboardCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width / 2 - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[400],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('$value',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      // child: ListTile(
      //   title: Text(title, style: const TextStyle(fontSize: 18)),
      //   trailing: Text('$value',
      //       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      // ),
    );
  }
}
