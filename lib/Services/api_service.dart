import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:om/Services/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  final String baseUrl = 'http://139.59.7.147:7071';
  SharedPreferences? prefs;

  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  // Login method
  Future<Map<String, dynamic>> login(String username, String password) async {
    final String url = '$baseUrl/api/auth/login';
    final Map<String, dynamic> body = {
      "userName": username,
      "password": password,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  // Fetch Driver Details method
  Future<Map<String, dynamic>> fetchDriverDetails(int driverId) async {
    final String url =
        '$baseUrl/dashboard/getCurrentVehicleStatsForDriver/$driverId';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['result'];
    } else {
      throw Exception('Failed');
    }
  }

  // Perform search method (moved from controller)
  Future<List<Map<String, dynamic>>> performSearch(
      int routeId, String searchString) async {
    final String url =
        '$baseUrl/driverOperations/getShopAutoComplete/$routeId/$searchString';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['statusCode'] == 200) {
        return (data['result'] as List<dynamic>)
            .map((item) => {'label': item['label'], 'id': item['id']})
            .toList();
      } else {
        throw Exception(data['message'] ?? 'Failed to fetch shops');
      }
    } else {
      throw Exception('Failed to fetch shops');
    }
  }

  // Save expiry material method (new)
  Future<Map<String, dynamic>> saveExpiryMaterial(
      String shopName, String totalAmount) async {
    final String url = '$baseUrl/driverOperations/saveExpiryMaterial';
    final Map<String, dynamic> body = {
      "shopName": shopName,
      "totalAmount": totalAmount,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to save expiry material');
    }
  }

  void logout() async {
    sharedPrefs.clearPreferences();
    Get.offAllNamed('/');
  }
}
