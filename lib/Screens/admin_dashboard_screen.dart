import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Services/api_service.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            APIService().logout();
            Get.offAllNamed('/');
          },
          child: const Text('Logout')),
    );
  }
}
