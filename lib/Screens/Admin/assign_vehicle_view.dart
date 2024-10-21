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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Employee Dropdown
            Obx(() {
              if (controller.isLoadingEmployees.value) {
                return Center(child: CircularProgressIndicator());
              }
              return DropdownButtonFormField<int>(
                value: controller.selectedEmployee.value == 0 ? null : controller.selectedEmployee.value,
                items: controller.employees
                    .map((employee) => DropdownMenuItem<int>(
                          value: employee.id,
                          child: Text(employee.label),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedEmployee.value = value ?? 0;
                },
                decoration: InputDecoration(labelText: 'Select Employee'),
              );
            }),
            SizedBox(height: 16),

            // Vehicle Dropdown
            Obx(() {
              if (controller.isLoadingVehicles.value) {
                return Center(child: CircularProgressIndicator());
              }
              return DropdownButtonFormField<int>(
                value: controller.selectedVehicle.value == 0 ? null : controller.selectedVehicle.value,
                items: controller.vehicles
                    .map((vehicle) => DropdownMenuItem<int>(
                          value: vehicle.id,
                          child: Text(vehicle.label),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedVehicle.value = value ?? 0;
                },
                decoration: InputDecoration(labelText: 'Select Vehicle'),
              );
            }),
            SizedBox(height: 16),

            // Route Dropdown
            Obx(() {
              if (controller.isLoadingRoutes.value) {
                return Center(child: CircularProgressIndicator());
              }
              return DropdownButtonFormField<int>(
                value: controller.selectedRoute.value == 0 ? null : controller.selectedRoute.value,
                items: controller.routes
                    .map((route) => DropdownMenuItem<int>(
                          value: route.id,
                          child: Text(route.label),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedRoute.value = value ?? 0;
                },
                decoration: InputDecoration(labelText: 'Select Route'),
              );
            }),
            SizedBox(height: 16),

            // Material Amount Input
            TextField(
              onChanged: (value) {
                controller.materialAmount.value = double.tryParse(value) ?? 0.0;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Material Amount'),
            ),
            SizedBox(height: 16),

            // Assign Vehicle Button
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
