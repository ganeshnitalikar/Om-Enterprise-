import 'package:get/get.dart';
import 'package:om/Api%20Service/Admin/Api.dart';

class EmployeeController extends GetxController {
  final ApiClass api = ApiClass();
  var employees = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  void fetchEmployees() async {
    isLoading(true);
    try {
      final fetchedEmployees = await api.fetchEmployeesforAdmin();
      employees.value = fetchedEmployees;
    } catch (e) {
      errorMessage('Error fetching employees: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateEmployee(int employeeId, String name, String role, String contact) async {
    try {
      final response = await api.updateEmployee(employeeId, name, role, contact);
      if (response['success']) {
        Get.snackbar('Success', 'Employee updated successfully!');
        fetchEmployees();
      } else {
        Get.snackbar('Error', 'Update failed: ${response['message']}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error updating employee: $e');
    }
  }

  Future<void> deleteEmployee(int employeeId) async {
    try {
      await api.deleteEmployee(employeeId);
      Get.snackbar('Success', 'Employee deleted successfully!');
      fetchEmployees();
    } catch (e) {
      Get.snackbar('Error', 'Error deleting employee: $e');
    }
  }
}
