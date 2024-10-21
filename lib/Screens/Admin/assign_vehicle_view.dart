// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Controllers/Admin/assign_vehicle_controller.dart';
import 'package:om/Utils/themes.dart';

class AssignVehicleScreen extends StatelessWidget {
  final AssignVehicleController controller = Get.put(AssignVehicleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text('Assign Vehicle', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Themes.light.colorScheme.background, // Custom AppBar color
        centerTitle: true,
=======
        title: const Text('Assign Vehicle'),
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header: Assignment Information
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Assignment Information',
                style: Themes.light.textTheme.headlineSmall,
              ),
            ),

            // Employee Dropdown
            Obx(() {
              if (controller.isLoadingEmployees.value) {
<<<<<<< HEAD
                return Center(child: CircularProgressIndicator());
              } else if (controller.employees.isEmpty) {
                return Center(child: Text('No employees available.'));
=======
                return const Center(child: CircularProgressIndicator());
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5
              }
              return DropdownButtonFormField<int>(
                value: controller.selectedEmployee.value == 0 ? null : controller.selectedEmployee.value,
                items: controller.employees.map((employee) {
                  return DropdownMenuItem<int>(
                    value: employee['id'],
                    child: Text(employee['label']),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedEmployee.value = value ?? 0;
                },
<<<<<<< HEAD
                decoration: InputDecoration(
                  labelText: 'Select Employee',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
=======
                decoration: const InputDecoration(labelText: 'Select Employee'),
              );
            }),
            const SizedBox(height: 16),
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5

            // Vehicle Dropdown
            Obx(() {
              if (controller.isLoadingVehicles.value) {
<<<<<<< HEAD
                return Center(child: CircularProgressIndicator());
              } else if (controller.vehicles.isEmpty) {
                return Center(child: Text('No vehicles available.'));
=======
                return const Center(child: CircularProgressIndicator());
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5
              }
              return DropdownButtonFormField<int>(
                value: controller.selectedVehicle.value == 0 ? null : controller.selectedVehicle.value,
                items: controller.vehicles.map((vehicle) {
                  return DropdownMenuItem<int>(
                    value: vehicle['id'],
                    child: Text(vehicle['label']),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedVehicle.value = value ?? 0;
                },
<<<<<<< HEAD
                decoration: InputDecoration(
                  labelText: 'Select Vehicle',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
=======
                decoration: const InputDecoration(labelText: 'Select Vehicle'),
              );
            }),
            const SizedBox(height: 16),
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5

            // Route Dropdown
            Obx(() {
              if (controller.isLoadingRoutes.value) {
<<<<<<< HEAD
                return Center(child: CircularProgressIndicator());
              } else if (controller.routes.isEmpty) {
                return Center(child: Text('No routes available.'));
=======
                return const Center(child: CircularProgressIndicator());
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5
              }
              return DropdownButtonFormField<int>(
                value: controller.selectedRoute.value == 0 ? null : controller.selectedRoute.value,
                items: controller.routes.map((route) {
                  return DropdownMenuItem<int>(
                    value: route['id'],
                    child: Text(route['label']),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedRoute.value = value ?? 0;
                },
<<<<<<< HEAD
                decoration: InputDecoration(
                  labelText: 'Select Route',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
=======
                decoration: const InputDecoration(labelText: 'Select Route'),
              );
            }),
            const SizedBox(height: 16),
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5

            // Material Amount Input
            TextField(
              onChanged: (value) {
                controller.materialAmount.value = double.tryParse(value) ?? 0.0;
              },
              keyboardType: TextInputType.number,
<<<<<<< HEAD
              decoration: InputDecoration(
                labelText: 'Enter Material Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Assign Vehicle Button
            Obx(() {
              return ElevatedButton(
                onPressed: (controller.selectedEmployee.value == 0 ||
                        controller.selectedVehicle.value == 0 ||
                        controller.selectedRoute.value == 0 ||
                        controller.materialAmount.value <= 0.0 ||
                        controller.isLoadingEmployees.value ||
                        controller.isLoadingVehicles.value ||
                        controller.isLoadingRoutes.value)
                    ? null
                    : () {
                        controller.assignVehicle();
                        // Clear fields after assignment
                        controller.selectedEmployee.value = 0;
                        controller.selectedVehicle.value = 0;
                        controller.selectedRoute.value = 0;
                        controller.materialAmount.value = 0.0;
                        // Pop the page
                        Get.back();
                      },
                child: Text(
                  'Assign Vehicle',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }),
=======
              decoration: const InputDecoration(labelText: 'Enter Material Amount'),
            ),
            const SizedBox(height: 16),

            // Assign Vehicle Button
            ElevatedButton(
              onPressed: () {
                controller.assignVehicle();
              },
              child: const Text('Assign Vehicle'),
            ),
>>>>>>> 49698c5286fc4adadd4cb6a4d37e293808b90be5
          ],
        ),
      ),
    );
  }
}
