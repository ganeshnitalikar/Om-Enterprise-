class Shop {
  final String shopName;
  final String shopContact;
  final int routeId;
  final bool isActive;
  final int createdBy;
  final int updatedBy;

  Shop({
    required this.shopName,
    required this.shopContact,
    required this.routeId,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'shopName': shopName,
      'shopContact': shopContact,
      'routeId': {'id': routeId},
      'isActive': isActive,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }
}
