// assign_vehicle_model.dart
class AssignVehicleModel {
  final String employeeId;
  final String vehicleId;
  final String routeId;
  final double materialAmount;

  AssignVehicleModel({
    required this.employeeId,
    required this.vehicleId,
    required this.routeId,
    required this.materialAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'vehicleId': vehicleId,
      'routeId': routeId,
      'materialAmount': materialAmount,
    };
  }
}
