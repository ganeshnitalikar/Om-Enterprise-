import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:html' as html; // For web image uploading

class EmployeeService {
  // Fetch roles from the API
  Future<List<Map<String, dynamic>>> fetchRoles() async {
    final response = await http.get(Uri.parse('http://139.59.7.147:7071/masters/getRoleDropDown'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body)['result']);
    } else {
      throw Exception('Failed to load roles');
    }
  }

  // Convert file to base64 string
  Future<String> _convertFileToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }

  // Convert web file to base64 string
  Future<String> _convertWebFileToBase64(html.File webImageFile) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(webImageFile);
    await reader.onLoad.first;
    final bytes = reader.result as List<int>;
    return base64Encode(bytes);
  }

  // Save employee with base64 image
  // Save employee with base64 image
Future<void> saveEmployee(Map<String, dynamic> employeeData, String role, {File? imageFile, html.File? webImageFile}) async {
    if (imageFile != null) {
      // Convert the mobile image file to base64
      String base64Image = await _convertFileToBase64(imageFile);
      employeeData['photo'] = base64Image;
    } else if (webImageFile != null) {
      // Convert the web image file to base64
      String base64Image = await _convertWebFileToBase64(webImageFile);
      employeeData['photo'] = base64Image;
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
    if (response.statusCode == 200) { // Change to 200
      print('Employee saved successfully');
    } else {
      print('Error saving employee: ${response.body}');
      throw Exception('Failed to save employee: ${response.body}');
    }
}

//To show the cards on screen
// Fetch all employees from the API
  Future<List<Map<String, dynamic>>> fetchEmployees() async {
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


  //update employee
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

//delete
  Future<void> deleteEmployee(int employeeId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://139.59.7.147:7071/masters/deleteEmployeeById/$employeeId'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete employee');
      }
    } catch (error) {
      throw Exception('Error deleting employee: $error');
    }
  }

}
