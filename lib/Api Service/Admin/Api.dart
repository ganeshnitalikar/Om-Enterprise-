// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:om/Model/Admin/VehicleModel.dart';
import 'package:om/Model/Admin/route_model.dart';
import 'package:om/Model/Admin/shop.dart';


class ApiClass {

    final Dio _dio = Dio();

  // Fetch roles from the API
  Future<List<Map<String, dynamic>>> fetchRoles() async {
    final response = await http.get(Uri.parse('http://139.59.7.147:7071/masters/getRoleDropDown'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body)['result']);
    } else {
      throw Exception('Failed to load roles');
    }
  }

  // Convert file to base64 string for mobile
  Future<String> _convertFileToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }

  // Save employee with base64 image
  Future<void> saveEmployee(Map<String, dynamic> employeeData, {File? imageFile}) async {
    String? base64Image;

    if (imageFile != null) {
      // Convert the mobile image file to base64
      base64Image = await _convertFileToBase64(imageFile);
      employeeData['photo'] = base64Image;
      print('Base64 Image (Mobile): $base64Image'); // Debug log
    } else {
      print('No image selected');
      // Handle case where no image is selected, if necessary
    }

    // Send the POST request with the employee data
    final response = await http.post(
      Uri.parse('http://139.59.7.147:7071/masters/saveEmployees'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(employeeData),
    );

    // Handle response
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Employee saved successfully: ${response.body}');
    } else {
      print('Error saving employee: ${response.body}');
      throw Exception('Failed to save employee: ${response.body}');
    }
  }

  //Use in the admin Dashboard
  Future<String> getUserRole() async {
    await Future.delayed(Duration(seconds: 2));
    return 'admin';
  }



 Future<List<Map<String, dynamic>>> fetchEmployees() async {
  const String url = 'http://139.59.7.147:7071/adminOperations/employeeDropDownForAssignVehicle';

  try {
    final response = await _dio.get(url);

    if (response.statusCode == 200 && response.data != null) {
      // Convert 'result' field to List<Map<String, dynamic>> format
      return List<Map<String, dynamic>>.from(response.data['result']);
    } else {
      throw Exception('Failed to load employees: HTTP ${response.statusCode}');
    }
  } on DioError catch (dioError) {
    // Handle specific Dio errors for debugging
    throw Exception('DioError occurred: ${dioError.message}');
  } catch (e) {
    // Catch any other errors
    throw Exception('Error fetching employees: $e');
  }
}

Future<List<Map<String, dynamic>>> fetchEmployeesforAdmin() async {
    final response = await http.post(
      Uri.parse('http://139.59.7.147:7071/masters/getEmployeeList'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}), // Sending an empty JSON object
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return List<Map<String, dynamic>>.from(responseBody['result']);
    } else {
      throw Exception('Failed to load employees');
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

  // Update employee
  Future<Map<String, dynamic>> updateEmployee(int id, String name, String role, String contact) async {
    final response = await http.post(
      Uri.parse('/employees/update'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        'name': name,
        'role': role,
        'contact': contact,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update employee');
    }
  }

  // Delete employee
  Future<bool> deleteEmployee(int employeeId) async {
    try {
      final response = await _dio.delete('http://139.59.7.147:7071/masters/deleteEmployeeById/$employeeId');
      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Dio Exception: ${e.message}');
      return false; // Indicate failure
    }
  }

  Future<List<dynamic>> fetchShops() async {
    try {
      final response = await _dio.get('your-api-endpoint/shops');
      if (response.statusCode == 200) {
        return response.data['result'];
      } else {
        throw Exception('Failed to load shops: ${response.data['message']}');
      }
    } catch (e) {
      print('Error fetching shops: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchBalanceReport() async {
    try {
      final response = await _dio.get('your-api-endpoint/balance-report');
      if (response.statusCode == 200) {
        return response.data; // Assuming the balance report is structured correctly
      } else {
        throw Exception('Failed to load balance report: ${response.data['message']}');
      }
    } catch (e) {
      print('Error fetching balance report: $e');
      return [];
    }
  }

 
 Future<void> saveRoute(RouteModel route) async {
    const apiUrl = 'http://139.59.7.147:7071/masters/saveRoute';
    final response = await _dio.post(apiUrl, data: route.toJson());
    return response.data;
  }

  Future<void> saveShop(Shop shop, String apiEndpoint) async {
    try {
      await _dio.post(apiEndpoint, data: shop.toJson());
    } catch (e) {
      print("Error saving shop: $e");
      throw Exception('Failed to save shop');
    }
  }


 Future<void> saveVehicle(VehicleModel vehicle) async {
    const apiUrl = 'http://139.59.7.147:7071/masters/saveVehicle';
    // vehicle_service.dart
try {
  final response = await _dio.post(apiUrl, 
    data: vehicle.toJson(), 
    options: Options(
      headers: {
        'Authorization': 'Bearer YOUR_API_KEY',
      },
    ));
  return response.data;
} catch (e) {
  if (e is DioError) {
    // Log the entire response for debugging
    print('DioError: ${e.response?.statusCode} ${e.response?.data}');
  } else {
    print('Error: $e');
  }
  throw e; // Re-throw for further handling
}
  }
}
