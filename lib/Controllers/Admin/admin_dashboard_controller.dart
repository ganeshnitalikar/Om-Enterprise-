import 'package:get/get.dart';
import 'package:om/Api%20Service/Admin/admin_service.dart';

class AdminDashboardController extends GetxController {
  final AdminService _adminService = AdminService();
  RxString userRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserRole();
  }

  void getUserRole() async {
    String role = await _adminService.getUserRole();
    userRole.value = role;
  }

  // You can add more logic for fetching specific data, like vehicle assignment, etc.
}
