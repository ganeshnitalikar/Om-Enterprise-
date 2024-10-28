import 'package:get/get.dart';
import 'package:om/Api%20Service/Admin/Api.dart';

class ReportController extends GetxController {
  final api = ApiClass();

  var selectedReport = ''.obs;
  var fromDate = ''.obs;
  var toDate = ''.obs;
  var shopId = 0.obs;
  var driverId = 0.obs;

  var reportData = <Map<String, dynamic>>[].obs;
  var shopDropdownItems = <DropdownItem>[].obs;
  var employeeDropdownItems = <DropdownItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDropdownData("employee"); // Fetch employee data for the dropdown initially
  }

Future<void> fetchReports() async {
  try {
    String fromDateString = fromDate.value; 
    String toDateString = toDate.value;     

    // Set the parameters for the API request
    var shopsIdValue = shopId.value; 
    int driverIdValue = driverId.value; 
    int pageValue = 1; // Set your desired page number
    int sizeValue = 10; // Set your desired page size

    // Debugging output
    print('Fetching balance report with parameters: '
          'fromDate: $fromDateString, toDate: $toDateString, '
          'shopsId: $shopsIdValue, driverId: $driverIdValue, '
          'isCollect: true, page: $pageValue, size: $sizeValue');

    // Call your API with the updated method signature
    var response = await api.fetchBalanceReport(
      fromDate: fromDateString,
      toDate: toDateString,
      shopsId: shopsIdValue,
      driverId: driverIdValue,
      isCollect: false,
      page: pageValue,
      size: sizeValue,
    );

    // Handle the response
    if (response != null && response['data'] != null) {
      reportData.value = List<Map<String, dynamic>>.from(response['data']);
      Get.snackbar("Success","Data fetched Successfully!!");
    } else {
      Get.snackbar("Error", "No data received from the report API.");
    }
  } catch (e) {
    Get.snackbar("Error", "Failed to fetch balance report: $e");
  }
}




  Future<void> fetchDropdownData(String type) async {
    try {
      var data = await api.fetchEmployees();
      if (type == "shop") {
        shopDropdownItems.value = data.map((item) => DropdownItem.fromJson(item)).toList();
      } else if (type == "employee") {
        employeeDropdownItems.value = data.map((item) => DropdownItem.fromJson(item)).toList();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load $type dropdown data: $e");
    }
  }
}

class DropdownItem {
  final int id;
  final String label;

  DropdownItem({required this.id, required this.label});

  factory DropdownItem.fromJson(Map<String, dynamic> json) {
    return DropdownItem(
      id: json['id'],
      label: json['label'],
    );
  }
}
