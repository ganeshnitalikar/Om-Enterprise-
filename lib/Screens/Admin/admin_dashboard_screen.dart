// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/admin_dashboard_controller.dart';
import 'package:om/Screens/Admin/EmployeeScreen.dart';
import 'package:om/Screens/Admin/assign_vehicle_view.dart';
import 'package:om/Screens/Admin/route_view.dart';
import 'package:om/Screens/Admin/shop_screen.dart';
import 'package:om/Screens/Admin/vehicle_view.dart';
import 'package:om/Utils/themes.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AdminDashboardController _controller = Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard',style: Themes.light.textTheme.headlineMedium,),
        backgroundColor: Themes.light.colorScheme.background
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
              color:Themes.light.colorScheme.background,
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
                          Get.to(() => EmployeeScreen());
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
                          Get.to(ShopScreen());
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
