import 'package:get/get.dart';
import 'package:om/Api%20Service/Admin/Api.dart';

class AssignVehicleController extends GetxController {
   final api=new ApiClass(); // Create an instance of the service

  var isLoadingEmployees = true.obs;
  var isLoadingVehicles = true.obs;
  var isLoadingRoutes = true.obs;

  var selectedEmployee = 0.obs;
  var selectedVehicle = 0.obs;
  var selectedRoute = 0.obs;
  var materialAmount = 0.0.obs;

  var employees = <Map<String, dynamic>>[].obs; 
  var vehicles = <Map<String, dynamic>>[].obs; 
  var routes = <Map<String, dynamic>>[].obs; 

  @override
  void onInit() {
    fetchEmployees();
    fetchVehicles();
    fetchRoutes();
    super.onInit();
  }

  void fetchEmployees() async {
    isLoadingEmployees(true);
    try {
      final response = await api.fetchEmployees();
      if (response.isNotEmpty) {
        employees.value = response; // Directly assigning raw data
      }
    } catch (error) {
      print('Error fetching employees: $error'); // Handle the error
    } finally {
      isLoadingEmployees(false);
    }
  }

  void fetchVehicles() async {
    isLoadingVehicles(true);
    try {
      final response = await api.fetchVehicles();
      if (response.isNotEmpty) {
        vehicles.value = response; // Directly assigning raw data
      }
    } catch (error) {
      print('Error fetching vehicles: $error'); // Handle the error
    } finally {
      isLoadingVehicles(false);
    }
  }

  void fetchRoutes() async {
    isLoadingRoutes(true);
    try {
      final response = await api.fetchRoutes();
      if (response.isNotEmpty) {
        routes.value = response; // Directly assigning raw data
      }
    } catch (error) {
      print('Error fetching routes: $error'); // Handle the error
    } finally {
      isLoadingRoutes(false);
    }
  }

Future<void> assignVehicle() async {
  // Validate the input fields before sending the request
  if (selectedEmployee.value == 0 ||
      selectedVehicle.value == 0 ||
      selectedRoute.value == 0 ||
      materialAmount.value <= 0) {
    Get.snackbar('Error', 'Please select all fields and enter a valid material amount');
    return;
  }

  // Construct the payload according to the expected format
  final Map<String, dynamic> data = {
    'employeeId': {'id': selectedEmployee.value},
    'vehicleId': {'id': selectedVehicle.value},
    'routeId': {'id': selectedRoute.value},
    'totalMaterial': materialAmount.value,
    'assignById': {'id': 1} // Assuming this is static or you can modify accordingly
  };

  print('Payload: $data'); // Log the payload for debugging

  try {
    // Call the assign vehicle service method with the constructed payload
    final result = await api.assignVehicle(data);
    print('API Response: $result'); // Log the response for debugging

    // Check for errors in the API response
    if (result['error'] == true) {
      Get.snackbar('Error', result['message']);
    } else {
      Get.snackbar('Success', 'Vehicle assigned successfully');
    }
  } catch (e) {
    print('Exception: $e'); // Log any exceptions for debugging
    Get.snackbar('Error', 'Failed to assign vehicle: $e');
  }
}

@override
void onClose() {
    super.onClose();
    
  }

}
