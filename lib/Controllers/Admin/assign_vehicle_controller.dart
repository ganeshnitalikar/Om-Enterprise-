import 'package:get/get.dart';
import 'package:om/Model/Admin/Vehicle.dart';
import 'package:om/Model/Admin/assign_vehicle_model.dart';
import 'package:om/Model/Admin/route.dart';
import '../../Api Service/Admin/assign_vehicle_service.dart';

class AssignVehicleController extends GetxController {
  final AssignVehicleService service = AssignVehicleService(); // Create an instance of the service

  var isLoadingEmployees = true.obs;
  var isLoadingVehicles = true.obs;
  var isLoadingRoutes = true.obs;

  var selectedEmployee = 0.obs;
  var selectedVehicle = 0.obs;
  var selectedRoute = 0.obs;
  var materialAmount = 0.0.obs;

  var employees = <AssignVehicleModel>[].obs; // Changed to use Employee model
  var vehicles = <Vehicle>[].obs; // Changed to use Vehicle model
  var routes = <Route>[].obs; // Changed to use Route model

  @override
  void onInit() {
    fetchEmployees();
    fetchVehicles();
    fetchRoutes();
    super.onInit();
  }

  void fetchEmployees() async {
    isLoadingEmployees(true);
    try {
      final response = await service.fetchEmployees();
      if (response.isNotEmpty) {
        employees.value = response.map((e) => AssignVehicleModel.fromJson(e as Map<String, dynamic>)).toList(); // Assuming Employee model has fromJson
      }
    } catch (error) {
      print('Error fetching employees: $error'); // Handle the error
    } finally {
      isLoadingEmployees(false);
    }
  }

  void fetchVehicles() async {
    isLoadingVehicles(true);
    try {
      final response = await service.fetchVehicles();
      if (response.isNotEmpty) {
        vehicles.value = response.map((v) => Vehicle.fromJson(v as Map<String, dynamic>)).toList(); // Assuming Vehicle model has fromJson
      }
    } catch (error) {
      print('Error fetching vehicles: $error'); // Handle the error
    } finally {
      isLoadingVehicles(false);
    }
  }

  void fetchRoutes() async {
    isLoadingRoutes(true);
    try {
      final response = await service.fetchRoutes();
      if (response.isNotEmpty) {
        routes.value = response.map((r) => Route.fromJson(r as Map<String, dynamic>)).toList(); // Assuming Route model has fromJson
      }
    } catch (error) {
      print('Error fetching routes: $error'); // Handle the error
    } finally {
      isLoadingRoutes(false);
    }
  }

  void assignVehicle() async {
    // Prepare data for assignment
    final data = {
      'employeeId': selectedEmployee.value,
      'vehicleId': selectedVehicle.value,
      'routeId': selectedRoute.value,
      'totalMaterial': materialAmount.value,
      'assignById': 'your-assigner-id' // Provide this as per your requirements
    };

    try {
      final result = await service.assignVehicle(data);
      print('Vehicle assigned: $result'); // Handle the response as needed
    } catch (error) {
      print('Error assigning vehicle: $error'); // Handle the error
    }
  }
}
