// vehicle_service.dart
// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:om/Model/Admin/VehicleModel.dart';

class VehicleService {
  final Dio _dio = Dio();

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
