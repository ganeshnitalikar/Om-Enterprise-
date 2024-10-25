import 'package:get/get.dart';
import 'package:om/Api%20Service/Admin/Api.dart';

class AdminDashboardController extends GetxController {
   final api=new ApiClass();
  RxString userRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserRole();
  }

  void getUserRole() async {
    String role = await api.getUserRole();
    userRole.value = role;
  }

  // You can add more logic for fetching specific data, like vehicle assignment, etc.
}
