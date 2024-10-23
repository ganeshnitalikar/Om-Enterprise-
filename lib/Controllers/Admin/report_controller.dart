import 'package:get/get.dart';

class ReportController extends GetxController {
  // List of shops fetched from the API
  var shops = [].obs;

  // List of employees fetched from the API
  var employees = [].obs;

  // Selected values for dropdowns
  var selectedShop = ''.obs; // Holds the selected shop ID
  var selectedEmployee = ''.obs; // Holds the selected employee ID
  var selectedStatus = ''.obs; // Holds the selected status

  // Selected report type (like 'Balance Report')
  var selectedReport = ''.obs;

  var fromDate = ''.obs; // Define fromDate
  var toDate = ''.obs; // Define toDate

  // Dummy balance report data (replace with real data fetched from the API)
  var balanceReport = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchShops(); // Fetch shops on initialization
    fetchEmployees(); // Fetch employees on initialization
  }

  // Fetch shops data from API (replace with actual API call)
  void fetchShops() async {
    try {
      // Simulate API call and response
      var response = [
        {'id': 1, 'name': 'Shop 1'},
        {'id': 2, 'name': 'Shop 2'},
        {'id': 3, 'name': 'Shop 3'}
      ];
      shops.value = response;
    } catch (e) {
      print('Error fetching shops: $e');
    }
  }

  // Fetch employees data from API (replace with actual API call)
  void fetchEmployees() async {
    try {
      // Simulate API call and response
      var response = [
        {'id': 1, 'name': 'Employee 1'},
        {'id': 2, 'name': 'Employee 2'},
        {'id': 3, 'name': 'Employee 3'}
      ];
      employees.value = response;
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }
  
}
