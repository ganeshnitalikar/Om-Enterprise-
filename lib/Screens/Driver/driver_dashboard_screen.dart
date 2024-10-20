import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/driver_dashboard_controller.dart';

class DriverDashboard extends StatelessWidget {
  final DriverDashboardController controller =
      Get.put(DriverDashboardController());
  final String username = Get.arguments['username'];

  DriverDashboard({super.key}); // Username passed from login screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    

                  )),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Shop Sales'),
              onTap: () {
                Get.toNamed('/shopSales'); // Navigate to Shop Sales screen
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
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report'),
              onTap: () {},
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
              // Row(
              //   children: [
              //     Text("Welcome, $username",
              //         style: const TextStyle(fontSize: 24)),
              //     Text(
              //       "Route Name: ${controller.routeName.value}",
              //       style: const TextStyle(fontSize: 24),
              //       overflow: TextOverflow.ellipsis,
              //     ),
              //   ],
              // ),
              DashboardCard(
                  title: 'Total Material',
                  value: controller.totalMaterial.value),
              DashboardCard(
                  title: 'Total Sale', value: controller.totalSale.value),
              DashboardCard(
                  title: 'Total Expense', value: controller.totalExpense.value),
              DashboardCard(
                  title: 'Current In Vehicle',
                  value: controller.currentInVehicle.value),
              DashboardCard(
                  title: 'Total Discount',
                  value: controller.totalDiscount.value),
            ],
          ),
        );
      }),
    );
  }
}

// Helper widget to display each card with data
class DashboardCard extends StatelessWidget {
  final String title;
  final double value;

  DashboardCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: Text('$value',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
