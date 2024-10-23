import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/driver_dashboard_controller.dart';
import 'package:om/Services/api_service.dart';
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
        backgroundColor: Get.theme.colorScheme.primary,
        title: const Text(
          "Driver Dashboard",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Get.dialog(Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Are you sure you want to logout?",
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              APIService().logout();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text("Yes"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                            ),
                            child: const Text("No"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Welcome, ", style: TextStyle(fontSize: 20)),
                        Text(controller.name.value,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Route Name: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Flexible(
                          child: Text(
                            controller.routeName.value,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildDashboardCards(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.primary,
            ),
            child: Text('Menu',
                style: Get.theme.textTheme.headlineLarge!
                    .copyWith(color: Colors.white)),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: 'Dashboard',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.store,
            text: 'Shop Sales',
            onTap: () {
              if (controller.assignId.value != 0 &&
                  controller.routeId.value != 0) {
                Get.toNamed('/driverShopSales');
              } else {
                Get.snackbar("Error", "Route not assigned");
              }
            },
          ),
          _buildDrawerItem(
            icon: Icons.money_off,
            text: 'Expiry Settlement',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.sms_failed,
            text: 'Expense Module',
            onTap: () {
              Get.toNamed('/driverExpense');
            },
          ),
          _buildDrawerItem(
            icon: Icons.report,
            text: 'Report',
            onTap: () {
              Get.toNamed('/driverReport');
            },
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Get.dialog(Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Are you sure you want to logout?",
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              APIService().logout();
                              print(sharedPrefs.getAssignId());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text("Yes"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                            ),
                            child: const Text("No"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Get.theme.colorScheme.secondary),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Get.theme.colorScheme.onBackground,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDashboardCards() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardCard(
                title: 'Total Sale', value: controller.totalSale.value),
            DashboardCard(
                title: "Total Material", value: controller.totalMaterial.value),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardCard(
                title: 'Total Expense', value: controller.totalExpense.value),
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
                title: 'Total Discount', value: controller.totalDiscount.value),
          ],
        ),
      ],
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
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 2.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue[300],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            const SizedBox(height: 10),
            Text('$value',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
