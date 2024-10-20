// vehicle_model.dart
class VehicleModel {
  final int id; // Add id field
  final String vehicleNo; // Change vehicleNumber to vehicleNo
  final bool isActive;
  final int createdBy;
  final int updatedBy;

  VehicleModel({
    required this.id,
    required this.vehicleNo,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id, // Include id in JSON
      "vehicleNo": vehicleNo, // Update field name
      "isActive": isActive,
      "createdBy": createdBy,
      "updatedBy": updatedBy,
    };
  }
}
