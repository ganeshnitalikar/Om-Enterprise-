import 'package:get/get.dart';
import 'package:om/Api%20Service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverDashboardController extends GetxController {
  var isLoading = true.obs;
  var totalMaterial = 0.0.obs;
  var totalSale = 0.0.obs;
  var totalExpense = 0.0.obs;
  var currentInVehicle = 0.0.obs;
  var totalDiscount = 0.0.obs;
  var totalMaterialReturnByShop = 0.obs;
  var routeName = ''.obs;
  SharedPreferences? prefs;
  var routeId = 0.obs;
  final APIService apiService = APIService();

  getSharedPreferences() async {
    prefs = await apiService.getSharedPreferences();
  }

  @override
  void onInit() {
    fetchDriverDetails(2);
    super.onInit();
  }

  void fetchDriverDetails(int driverId) async {
    try {
      isLoading(true);
      var result = await apiService.fetchDriverDetails(driverId);
      print("Result: $result");

      totalMaterial.value = _parseDouble(result['Total Material']);
      totalSale.value = _parseDouble(result['Total Sale']);
      totalExpense.value = _parseDouble(result['Total Expense']);
      currentInVehicle.value = _parseDouble(result['Current In Vehicle']);
      totalDiscount.value = _parseDouble(result['Total Discount']);
      routeName.value = result['Route Name'];

      // routeId.value = result['Route ID'];
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs?.setInt('routeId', routeId.value);

      // totalMaterialReturnByShop.value = 0;
    } catch (e) {
      print("Error in driver dashboard controller: $e");
      Get.snackbar("Error", "Failed to fetch driver details");
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
