import 'package:dio/dio.dart';

class AssignVehicleService {
  final Dio _dio = Dio();

  // Fetch employees directly from the backend
  Future<List<Map<String, dynamic>>> fetchEmployees() async {
    const String url = 'http://139.59.7.147:7071/adminOperations/employeeDropDownForAssignVehicle';
    
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 && response.data != null) {
        return List<Map<String, dynamic>>.from(response.data['result']); // Return raw data as List of Maps
      } else {
        throw Exception('Failed to load employees: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching employees: $e');
    }
  }

  // Fetch vehicles directly from the backend
  Future<List<Map<String, dynamic>>> fetchVehicles() async {
    const String url = 'http://139.59.7.147:7071/adminOperations/vehicleDropDownForAssignVehicle';
    
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 && response.data != null) {
        return List<Map<String, dynamic>>.from(response.data['result']); // Return raw data as List of Maps
      } else {
        throw Exception('Failed to load vehicles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching vehicles: $e');
    }
  }

  // Fetch routes directly from the backend
  Future<List<Map<String, dynamic>>> fetchRoutes() async {
    const String url = 'http://139.59.7.147:7071/adminOperations/routeDropDownForAssignVehicle';
    
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 && response.data != null) {
        return List<Map<String, dynamic>>.from(response.data['result']); // Return raw data as List of Maps
      } else {
        throw Exception('Failed to load routes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching routes: $e');
    }
  }

  // Assign vehicle with raw data from the form
  Future<Map<String, dynamic>> assignVehicle(Map<String, dynamic> data) async {
    const String url = 'http://139.59.7.147:7071/adminOperations/assignVehicle';

    try {
      final response = await _dio.post(url, data: data);
      if (response.statusCode == 200 && response.data != null) {
        return response.data; // Return raw response data
      } else {
        throw Exception('Failed to assign vehicle: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error assigning vehicle: $e');
    }
}


}
