import 'package:dio/dio.dart';

class ApiService {
  static final Dio dio = Dio();

  // Fetch shops
  static Future<List<dynamic>> fetchShops() async {
    try {
      final response = await dio.get('your-api-endpoint/shops');
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

  // Fetch employees
  static Future<List<dynamic>> fetchEmployees() async {
    try {
      final response = await dio.get('http://139.59.7.147:7071/adminOperations/getAllEmployeeListForAttendance');
      if (response.statusCode == 200) {
        return response.data['result'];
      } else {
        throw Exception('Failed to load employees: ${response.data['message']}');
      }
    } catch (e) {
      print('Error fetching employees: $e');
      return [];
    }
  }

  // Fetch balance report
  static Future<List<dynamic>> fetchBalanceReport() async {
    try {
      final response = await dio.get('your-api-endpoint/balance-report');
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
}
