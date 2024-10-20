class Vehicle {
  final int id;
  final String label;
  final String value; // Added value field

  Vehicle({required this.id, required this.label, required this.value});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      label: json['label'],
      value: json['value'], // Added value field
    );
  }
}
