import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/admin_dashboard_controller.dart';
import 'package:om/Screens/Admin/EmployeeScreen.dart';
import 'package:om/Screens/Admin/assign_vehicle_view.dart';
import 'package:om/Screens/Admin/route_view.dart';
import 'package:om/Screens/Admin/vehicle_view.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AdminDashboardController _controller =
      Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      drawer: _buildDrawer(context),
      body: Obx(() {
        // Display loading indicator if userRole isn't set yet
        if (_controller.userRole.value.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return Center(
          child: Text(
            'Welcome to Admin Dashboard',
            style: TextStyle(fontSize: 24),
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
              color: Colors.blue,
            ),
            child: Text(
              'Admin Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
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
                    title: Text('Masters'),
                    leading: Icon(Icons.settings),
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Employee'),
                        onTap: () {
                          Get.to(() => Placeholder());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.map),
                        title: Text('Route'),
                        onTap: () {
                          Get.to(() => RouteView());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.store),
                        title: Text('Shop'),
                        onTap: () {
                          // Navigate to Shop Page (to be implemented)
                          // Get.to(() => ShopScreen());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text('Vehicle'),
                        onTap: () {
                          Get.to(() => VehicleView());
                        },
                      ),
                    ],
                  ),
                  // Vehicle Assignment section
                  ListTile(
                    leading: Icon(Icons.directions_car_filled),
                    title: Text('Vehicle Assignment'),
                    onTap: () {
                      Get.to(() => AssignVehicleScreen());
                    },
                  ),
                ],
              );
            } else if (_controller.userRole.value == 'driver') {
              // Only show Vehicle Assignment for drivers
              return ListTile(
                leading: Icon(Icons.directions_car_filled),
                title: Text('Vehicle Assignment'),
                onTap: () {
                  // Navigate to Vehicle Assignment Page (to be implemented)
                  // Get.to(() => VehicleAssignmentScreen());
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
