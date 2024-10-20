import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Api%20Service/Admin/assign_vehicle_service.dart';

class AssignVehicleController extends GetxController {
  // Dropdown values
  var employees = <DropdownMenuItem<int>>[].obs;
  var vehicles = <DropdownMenuItem<int>>[].obs;
  var routes = <DropdownMenuItem<int>>[].obs;

  var selectedEmployee = 0.obs;
  var selectedVehicle = 0.obs;
  var selectedRoute = 0.obs;

  var materialAmount = 0.0.obs;
  var assignById = 2.obs; // Hardcoded for now, replace with dynamic ID if needed

  final AssignVehicleService service = AssignVehicleService(); // Service instance

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
    fetchVehicles();
    fetchRoutes();
  }

  // Fetch employees from service
  Future<void> fetchEmployees() async {
    var data = await service.fetchEmployees();
    employees.value = data.map<DropdownMenuItem<int>>((item) {
      return DropdownMenuItem<int>(
        value: item['id'],
        child: Text(item['label']),
      );
    }).toList();
  }

  // Fetch vehicles from service
  Future<void> fetchVehicles() async {
    var data = await service.fetchVehicles();
    vehicles.value = data.map<DropdownMenuItem<int>>((item) {
      return DropdownMenuItem<int>(
        value: item['id'],
        child: Text(item['label']),
      );
    }).toList();
  }

  // Fetch routes from service
  Future<void> fetchRoutes() async {
    var data = await service.fetchRoutes();
    routes.value = data.map<DropdownMenuItem<int>>((item) {
      return DropdownMenuItem<int>(
        value: item['id'],
        child: Text(item['label']),
      );
    }).toList();
  }

  // Assign vehicle using the service
   Future<void> assignVehicle() async {
    var data = {
      'employeeId': {'id': selectedEmployee.value},
      'vehicleId': {'id': selectedVehicle.value},
      'routeId': {'id': selectedRoute.value},
      'totalMaterial': materialAmount.value,
      'assignById': {'id': assignById.value},
    };

    var result = await service.assignVehicle(data);
    if (result) {
      Get.snackbar('Success', 'Vehicle Assigned Successfully');
    } else {
      Get.snackbar('Error', 'Failed to Assign Vehicle');
    }
  }
}
