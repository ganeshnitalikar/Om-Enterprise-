class AssignVehicleModel {
  final int id;
  final String label;
  final String value; // Added value field

  AssignVehicleModel({required this.id, required this.label, required this.value});

  factory AssignVehicleModel.fromJson(Map<String, dynamic> json) {
    return AssignVehicleModel(
      id: json['id'],
      label: json['label'],
      value: json['value'], // Added value field
    );
  }
}
