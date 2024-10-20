import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Screens/Admin/admin_dashboard_screen.dart';
import 'package:om/Screens/Driver/driver_dashboard_screen.dart';
import 'package:om/Screens/Driver/login_screen.dart';
import 'package:om/Screens/Driver/shop_sales_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driver Dashboard',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/driverDashboard', page: () => DriverDashboard()),
        GetPage(
            name: '/shopSales',
            page: () => ShopSalesScreen()),
        GetPage(name: '/AdminDashboard', page: () => AdminDashboardScreen()),
      ],
    );
  }
}
