import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Screens/Admin/admin_dashboard_screen.dart';
import 'package:om/Screens/Driver/driver_dashboard_screen.dart';
import 'package:om/Screens/Driver/login_screen.dart';
import 'package:om/Screens/Driver/driver_expense_screen.dart';
import 'package:om/Screens/Driver/shop_sales_screen.dart';
import 'package:om/Screens/admin_dashboard_screen.dart';
import 'package:om/Services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init(); //
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> getLoginStatus() async {
    String? token = sharedPrefs.getToken();
    String? role = sharedPrefs.getEmployeeRole();

    if (token != null && role != null) {
      return role; 
    }
    return null; 
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driver Dashboard',
      home: FutureBuilder<String?>(
        future: getLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); 
          } else if (snapshot.hasData) {
            
            if (snapshot.data == 'Driver') {
              return DriverDashboard();
            } else if (snapshot.data == 'Admin') {
              return const AdminDashboard();
            } else {
              return LoginScreen(); 
            }
          } else {
            // Not logged in, show login screen
            return LoginScreen();
          }
        },
      ),
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/driverDashboard', page: () => DriverDashboard()),
        GetPage(name: '/adminDashboard', page: () => const AdminDashboard()),
        GetPage(name: '/driverExpense', page: () => PersonalExpenseScreen()),
        GetPage(name: '/shopSales', page: () => ShopSalesScreen()),
        GetPage(name: '/AdminDashboard', page: () => AdminDashboardScreen()),
      ],
    );
  }
}
