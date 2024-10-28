import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/admin_dashboard_controller.dart';
import 'package:om/Screens/Admin/report_screen.dart';
import 'package:om/Services/shared_preferences_service.dart';
import 'package:om/Screens/Admin/EmployeeScreen.dart';
import 'package:om/Screens/Admin/assign_vehicle_view.dart';
import 'package:om/Screens/Admin/route_view.dart';
import 'package:om/Screens/Admin/shop_screen.dart';
import 'package:om/Screens/Admin/vehicle_view.dart';
import 'package:om/Utils/utils.dart';

import '../Driver/login_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AdminDashboardController _controller = Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Check if the user is authenticated
    _checkAuthentication();

    return Scaffold(
      appBar: buildAppBar(theme: theme, title: "Admin DashBoard"),
      drawer: _buildDrawer(),
      body: Obx(() {
        if (_controller.userRole.value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _welcomeCard(),
              const SizedBox(height: 20),
              _quickActionsCard(),
            ],
          ),
        );
      }),
    );
  }

  // Check if the user is authenticated, if not, redirect to the login page
  void _checkAuthentication() async {
    String? token = await sharedPrefs.getToken(); // Assuming token is saved in shared preferences
    if (token == null || token.isEmpty) {
      Get.offAll(() => LoginScreen()); // Redirect to login if not authenticated
    }
  }

  Widget _welcomeCard() {
    return Card(
      elevation: 4,
      shadowColor: Colors.teal.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Welcome to Admin Dashboard',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Manage your employees, routes, vehicles, and assignments efficiently.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickActionsCard() {
    return Card(
      elevation: 4,
      shadowColor: Colors.teal.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _actionButton('Employees', Icons.person, Colors.green, EmployeeScreen()),
                _actionButton('Routes', Icons.map, Colors.orange, RouteView()),
                _actionButton('Shops', Icons.store, Colors.purple, ShopScreen()),
                _actionButton('Vehicles', Icons.directions_car, Colors.red, VehicleView()),
                _actionButton('Assign Vehicle', Icons.assignment, Colors.blue, AssignVehicleScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String title, IconData icon, Color color, Widget screen) {
    return GestureDetector(
      onTap: () => Get.to(() => screen),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(15),
            child: Icon(icon, size: 40, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade800, Colors.teal.shade400],
              ),
            ),
            child: const Text(
              'Admin Menu',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(() {
            switch (_controller.userRole.value) {
              case 'admin':
                return _adminMenu();
              case 'driver':
                return _driverMenu();
              default:
                return Container();
            }
          }),
        ],
      ),
    );
  }

  Widget _adminMenu() {
    return Column(
      children: [
        ExpansionTile(
          title: const Text('Masters', style: TextStyle(fontWeight: FontWeight.bold)),
          leading: const Icon(Icons.settings, color: Colors.blueAccent),
          children: <Widget>[
            _buildListTile(Icons.person, 'Employee', Colors.greenAccent, EmployeeScreen()),
            _buildListTile(Icons.map, 'Route', Colors.orangeAccent, RouteView()),
            _buildListTile(Icons.store, 'Shop', Colors.purpleAccent, ShopScreen()),
            _buildListTile(Icons.directions_car, 'Vehicle', Colors.redAccent, VehicleView()),
          ],
        ),
        _buildListTile(Icons.directions_car_filled, 'Vehicle Assignment', Colors.tealAccent, AssignVehicleScreen()),
        _buildListTile(Icons.report, 'Report Screen', Colors.tealAccent, ReportScreen()),
        _logoutTile(),
      ],
    );
  }

  Widget _driverMenu() {
    return _buildListTile(Icons.directions_car_filled, 'Vehicle Assignment', Colors.tealAccent, AssignVehicleScreen());
  }

  ListTile _buildListTile(IconData icon, String title, Color color, Widget screen) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: () => Get.to(() => screen),
    );
  }

  ListTile _logoutTile() {
    return ListTile(
      leading: const Icon(Icons.logout),
      title: const Text('Logout'),
      onTap: () {
        Get.dialog(
          Dialog(
            child: Padding(
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
                          // Clear user token or session data
                          sharedPrefs.clearPreferences();
                          Get.offAll(() => LoginScreen()); // Redirect to login page
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
    );
  }
}
