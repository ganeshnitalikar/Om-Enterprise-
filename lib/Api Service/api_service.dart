import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  final String baseUrl = 'http://139.59.7.147:7071';
  SharedPreferences? prefs;

  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

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
}
