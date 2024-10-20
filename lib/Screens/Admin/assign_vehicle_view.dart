import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/assign_vehicle_controller.dart';

class AssignVehicleScreen extends StatelessWidget {
  final AssignVehicleController controller = Get.put(AssignVehicleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => DropdownButtonFormField<int>(
                  value: controller.selectedEmployee.value,
                  items: controller.employees,
                  onChanged: (value) {
                    controller.selectedEmployee.value = value!;
                  },
                  decoration: InputDecoration(labelText: 'Select Employee'),
                )),
            SizedBox(height: 16),
            Obx(() => DropdownButtonFormField<int>(
                  value: controller.selectedVehicle.value,
                  items: controller.vehicles,
                  onChanged: (value) {
                    controller.selectedVehicle.value = value!;
                  },
                  decoration: InputDecoration(labelText: 'Select Vehicle'),
                )),
            SizedBox(height: 16),
            Obx(() => DropdownButtonFormField<int>(
                  value: controller.selectedRoute.value,
                  items: controller.routes,
                  onChanged: (value) {
                    controller.selectedRoute.value = value!;
                  },
                  decoration: InputDecoration(labelText: 'Select Route'),
                )),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter Material Amount'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.materialAmount.value = double.tryParse(value) ?? 0.0;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.assignVehicle();
              },
              child: Text('Assign Vehicle'),
            ),
          ],
        ),
      ),
    );
  }
}
