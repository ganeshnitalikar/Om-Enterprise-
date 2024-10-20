// admin_service.dart
class AdminService {
  // Example function to get user roles from backend
  Future<String> getUserRole() async {
    // Simulate a call to the backend
    await Future.delayed(Duration(seconds: 2));
    // For this example, we'll assume it's an Admin
    return 'admin'; // could be 'driver' or 'admin'
  }

  // You can add more functions for handling data, like fetching employee details, etc.
}
