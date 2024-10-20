import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Screens/Admin/admin_dashboard_screen.dart';
import 'package:om/Screens/Driver/driver_dashboard_screen.dart';
import 'package:om/Screens/Driver/driver_expense_screen.dart';
import 'package:om/Screens/Driver/login_screen.dart';
import 'package:om/Screens/Driver/shop_sales_screen.dart';
import 'package:om/Screens/admin_dashboard_screen.dart';
import 'package:om/Services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  await sharedPrefs.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driver Dashboard',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/driverDashboard', page: () => DriverDashboard()),
        GetPage(name: '/adminDashboard', page: () => const AdminDashboard()),
        GetPage(name: '/driverExpense', page: () => DriverExpenseScreen()),
        GetPage(
            name: '/shopSales',
            page: () => ShopSalesScreen()),
        GetPage(name: '/AdminDashboard', page: () => AdminDashboardScreen()),
      ],
    );
  }
}
