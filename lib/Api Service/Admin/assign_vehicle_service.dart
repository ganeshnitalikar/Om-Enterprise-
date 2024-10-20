// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

class AssignVehicleService {
  Dio dio = Dio(); // Initialize Dio for API calls

  // Fetch employees from backend
  Future<List<dynamic>> fetchEmployees() async {
    var response = await dio.post('http://139.59.7.147:7071/adminOperations/employeeDropDownForAssignVehicle', data: {});
    if (response.statusCode == 200) {
      return response.data['result'];
    }
    return [];
  }

  // Fetch vehicles from backend
  Future<List<dynamic>> fetchVehicles() async {
    var response = await dio.post('http://139.59.7.147:7071/adminOperations/vehicleDropDownForAssignVehicle', data: {});
    if (response.statusCode == 200) {
      return response.data['result'];
    }
    return [];
  }

  // Fetch routes from backend
  Future<List<dynamic>> fetchRoutes() async {
    var response = await dio.post('http://139.59.7.147:7071/adminOperations/routeDropDownForAssignVehicle', data: {});
    if (response.statusCode == 200) {
      return response.data['result'];
    }
    return [];
  }

  // Assign vehicle
  Future<bool> assignVehicle(Map<String, dynamic> data) async {
    try {
      final response = await dio.post('http://139.59.7.147:7071/adminOperations/assignVehicle', data: data);
      if (response.statusCode == 200) {
        return true; // Success
      } else if (response.statusCode == 405) {
        print('Method Not Allowed: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      print('Dio Exception: ${e.message}');
      return false; // Indicate failure
    }
    return false; // Default case
  }
}
