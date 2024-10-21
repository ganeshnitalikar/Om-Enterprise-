import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Driver/expiry_material_controller.dart';

class ExpiryMaterialScreen extends StatelessWidget {
  final ExpiryMaterialController controller =
      Get.put(ExpiryMaterialController());

   ExpiryMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expiry Material by Shop')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.shopNameController,
              decoration: const InputDecoration(labelText: 'Shop Name'),
            ),
            TextField(
              controller: controller.totalAmountController,
              decoration: const InputDecoration(labelText: 'Total Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.saveExpiryMaterial,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
