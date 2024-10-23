import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: Get.theme.textTheme.headlineLarge?.copyWith(
            color: Get.theme.colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.dialog(
                Dialog(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Are you sure you want to logout?"),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                sharedPrefs.clearPreferences();
                                Get.back();
                                Get.offAllNamed('/');
                              },
                              child: const Text("Yes"),
                            ),
                            ElevatedButton(
                              onPressed: () => Get.back(),
                              child: const Text("No"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.primary,
              ),
              child: Text(
                'Menu',
                style: Get.theme.textTheme.headlineLarge!.copyWith(
                  color: Get.theme.colorScheme.onPrimary,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: Text(
                'Dashboard',
                style: Get.theme.textTheme.bodyLarge!.copyWith(
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: Text(
                'Shop Sales',
                style: Get.theme.textTheme.bodyLarge!.copyWith(
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
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
              title: Text(
                'Expiry Settlement',
                style: Get.theme.textTheme.bodyLarge!.copyWith(
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.sms_failed),
              title: Text(
                'Expense Module',
                style: Get.theme.textTheme.bodyLarge!.copyWith(
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
              onTap: () {
                Get.toNamed('/driverExpense');
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: Text(
                'Report',
                style: Get.theme.textTheme.bodyLarge!.copyWith(
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
              onTap: () {
                Get.toNamed('/driverReport');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'Logout',
                style: Get.theme.textTheme.bodyLarge!.copyWith(
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
              onTap: () {
                Get.dialog(
                  Dialog(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Are you sure you want to logout?"),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  sharedPrefs.clearPreferences();
                                  Get.offAllNamed('/login');
                                },
                                child: const Text("Yes"),
                              ),
                              ElevatedButton(
                                onPressed: () => Get.back(),
                                child: const Text("No"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          controller.fetchDriverDetails(sharedPrefs.getEmpId());
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
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            )),
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
                          controller.routeName.value,
                          softWrap: true,
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
                    title: 'Total Sale',
                    value: controller.totalSale.value,
                  ),
                  DashboardCard(
                    title: "Total Material",
                    value: controller.totalMaterial.value,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardCard(
                    title: 'Total Expense',
                    value: controller.totalExpense.value,
                  ),
                  DashboardCard(
                    title: 'Current In Vehicle',
                    value: controller.currentInVehicle.value,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardCard(
                    title: 'Total Discount',
                    value: controller.totalDiscount.value,
                  ),
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
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 2 - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.theme.colorScheme.secondary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Get.theme.textTheme.bodyLarge!.copyWith(
                  color: Get.theme.colorScheme.tertiary,
                )),
            const SizedBox(height: 10),
            Text(
              '$value',
              style: Get.theme.textTheme.bodyLarge!.copyWith(
                color: Get.theme.colorScheme.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
