
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/admin_dashboard_controller.dart';
import 'package:om/Screens/Admin/assign_vehicle_view.dart';
import 'package:om/Screens/Admin/route_view.dart';
import 'package:om/Screens/Admin/shop_screen.dart';
import 'package:om/Screens/Admin/vehicle_view.dart';
import 'package:om/Utils/utils.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AdminDashboardController _controller =
      Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Admin Dashboard',
            style: Themes.light.textTheme.headlineMedium,
          ),
          backgroundColor: Themes.light.colorScheme.background),
      drawer: _buildDrawer(context),
      body: Obx(() {
        // Display loading indicator if userRole isn't set yet
        if (_controller.userRole.value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(
          child: Text(
            'Welcome to Admin Dashboard',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
        );
      }),
    );
  }

  // Drawer widget for admin and driver roles
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Themes.light.colorScheme.background,
            ),
            child: Text(
              'Admin Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Display different menu items based on user role
          Obx(() {
            if (_controller.userRole.value == 'admin') {
              return Column(
                children: [
                  // Masters section with sub-menu
                  ExpansionTile(
                    title: const Text('Masters',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    leading:
                        const Icon(Icons.settings, color: Colors.blueAccent),
                    children: <Widget>[
                      ListTile(
                        leading:
                            const Icon(Icons.person, color: Colors.greenAccent),
                        title: const Text('Employee',
                            style: TextStyle(fontSize: 16)),
                        onTap: () {
                          Get.to(() => const Placeholder());
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.map, color: Colors.orangeAccent),
                        title:
                            const Text('Route', style: TextStyle(fontSize: 16)),
                        onTap: () {
                          Get.to(() => RouteView());
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.store, color: Colors.purpleAccent),
                        title:
                            const Text('Shop', style: TextStyle(fontSize: 16)),
                        onTap: () {
                          Get.to(ShopScreen());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.directions_car,
                            color: Colors.redAccent),
                        title: const Text('Vehicle',
                            style: TextStyle(fontSize: 16)),
                        onTap: () {
                          Get.to(() => VehicleView());
                        },
                      ),
                    ],
                  ),
                  // Vehicle Assignment section
                  ListTile(
                    leading: const Icon(Icons.directions_car_filled,
                        color: Colors.tealAccent),
                    title: const Text('Vehicle Assignment',
                        style: TextStyle(fontSize: 16)),
                    onTap: () {
                      Get.to(() => AssignVehicleScreen());
                    },
                  ),
                ],
              );
            } else if (_controller.userRole.value == 'driver') {
              // Only show Vehicle Assignment for drivers
              return ListTile(
                leading: const Icon(Icons.directions_car_filled,
                    color: Colors.tealAccent),
                title: const Text('Vehicle Assignment',
                    style: TextStyle(fontSize: 16)),
                onTap: () {
                  Get.to(() => AssignVehicleScreen());
                },
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }
}
