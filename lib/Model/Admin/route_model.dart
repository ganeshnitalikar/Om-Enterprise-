class RouteModel {
  final int id;
  final String route;
  final bool isActive;
  final int createdBy;
  final int updatedBy;

  RouteModel({
    required this.id,
    required this.route,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'route': route,
      'isActive': isActive,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }
}
