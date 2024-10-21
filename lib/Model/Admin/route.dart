class Route {
  final int id;
  final String label;
  final String value; // Added value field

  Route({required this.id, required this.label, required this.value});

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json['id'],
      label: json['label'],
      value: json['value'], // Added value field
    );
  }
}
