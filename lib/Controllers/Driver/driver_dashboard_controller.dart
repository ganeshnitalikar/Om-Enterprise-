import 'package:get/get.dart';
import 'package:om/Services/api_service.dart';
import 'package:om/Services/shared_preferences_service.dart';

class DriverDashboardController extends GetxController {
  var isLoading = true.obs;
  var totalMaterial = 0.0.obs;
  var totalSale = 0.0.obs;
  var totalExpense = 0.0.obs;
  var currentInVehicle = 0.0.obs;
  var totalDiscount = 0.0.obs;
  var totalMaterialReturnByShop = 0.obs;
  var name = ''.obs;
  var routeName = ''.obs;
  var assignId = 0.obs;
  var routeId = 0.obs;
  final APIService apiService = APIService();

  @override
  void onInit() {
    if (sharedPrefs.getEmpId() != 0) {
      fetchDriverDetails(sharedPrefs.getEmpId());
    }
    super.onInit();
  }

  void fetchDriverDetails(int driverId) async {
    try {
      isLoading(true);
      var result = await apiService.fetchDriverDetails(driverId);

      totalMaterial.value = _parseDouble(result['Total Material']);
      totalSale.value = _parseDouble(result['Total Sale']);
      totalExpense.value = _parseDouble(result['Total Expense']);
      currentInVehicle.value = _parseDouble(result['Current In Vehicle']);
      totalDiscount.value = _parseDouble(result['Total Discount']);
      name.value = result['Employee Name'];
      routeName.value = result['Route Name'];
      routeId.value = result['Route Id'];
      assignId.value = result['Assign Id'];

      sharedPrefs.setRouteId(routeId.value);
      sharedPrefs.setEmployeeName(name.value);
      sharedPrefs.setAssignId(assignId.value);
    } catch (e) {
      if (routeId.value == 0) {
        Get.snackbar("No Data To Show", "Driver Not Assigned Yet");
      } else {
        Get.snackbar("Error", "Failed to fetch driver details");
        Get.offAllNamed('/login');
      }
    } finally {
      isLoading(false);
    }
  }

  // Helper method to parse string numbers with commas into double
  double _parseDouble(String value) {
    try {
      value = value.replaceAll(',', '');
      return double.parse(value);
    } catch (e) {
      return 0.0;
    }
  }
}
