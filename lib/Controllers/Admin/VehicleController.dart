// vehicle_controller.dart
import 'package:get/get.dart';
import 'package:om/Api%20Service/Admin/VehicleService.dart';
import 'package:om/Model/Admin/VehicleModel.dart';

class VehicleController extends GetxController {
  final VehicleService _vehicleService = VehicleService();
  var vehicleNo = ''.obs;
  var isActive = false.obs;
  var createdBy = 2;
  var updatedBy = 2;

  void setVehicleNo(String number) {
    vehicleNo.value = number;
  }

  void toggleIsActive(bool value) {
    isActive.value = value;
  }

  Future<void> saveVehicle() async {
    // Validate input
    if (vehicleNo.value.isEmpty) {
      Get.snackbar('Error', 'Vehicle number cannot be empty');
      return;
    }

    final vehicle = VehicleModel(
      id: 1, // Set to 0 for new vehicles
      vehicleNo: vehicleNo.value,
      isActive: isActive.value,
      createdBy: createdBy,
      updatedBy: updatedBy,
    );

    try {
      await _vehicleService.saveVehicle(vehicle);
      Get.snackbar('Success', 'Vehicle saved successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save vehicle: ${e.toString()}');
    }
  }
}
