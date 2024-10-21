import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddEmployeeService {
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
}
