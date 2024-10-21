import 'package:dio/dio.dart';
import 'package:om/Model/Admin/assign_vehicle_model.dart';
import 'package:om/Model/Admin/route.dart';

import '../../Model/Admin/Vehicle.dart';

class AssignVehicleService {
  final Dio _dio = Dio();

  // Fetch employees
  Future<List<AssignVehicleModel>> fetchEmployees() async {
    try {
      final response = await _dio.post(
        'http://139.59.7.147:7071/adminOperations/employeeDropDownForAssignVehicle'
      );
      if (response.statusCode == 200) {
        return (response.data['result'] as List)
            .map((e) => AssignVehicleModel.fromJson(e))
            .toList(); // Deserialize to Employee model
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch vehicles
  Future<List<Vehicle>> fetchVehicles() async {
    try {
      final response = await _dio.post(
        'http://139.59.7.147:7071/adminOperations/vehicleDropDownForAssignVehicle'
      );
      if (response.statusCode == 200) {
        return (response.data['result'] as List)
            .map((v) => Vehicle.fromJson(v))
            .toList(); // Deserialize to Vehicle model
      } else {
        throw Exception('Failed to load vehicles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch routes
  Future<List<Route>> fetchRoutes() async {
    try {
      final response = await _dio.post(
        'http://139.59.7.147:7071/adminOperations/routeDropDownForAssignVehicle'
      );
      if (response.statusCode == 200) {
        return (response.data['result'] as List)
            .map((r) => Route.fromJson(r))
            .toList(); // Deserialize to Route model
      } else {
        throw Exception('Failed to load routes');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Assign vehicle
  Future<Map<String, dynamic>> assignVehicle(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        'http://139.59.7.147:7071/adminOperations/assignVehicle',
        data: data
      );
      return response.data;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
