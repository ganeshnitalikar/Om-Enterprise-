import 'package:flutter/material.dart';
import '../../Api Service/Admin/shop_service.dart';
import '../../Model/Admin/shop.dart';

class ShopController with ChangeNotifier {
  final ShopService _shopService = ShopService();
  List<dynamic> routes = [];
  String? selectedRouteId;
  bool isActive = false;

  Future<void> fetchRoutes(String apiEndpoint) async {
    routes = await _shopService.fetchRoutes(apiEndpoint);
    notifyListeners();
  }

  Future<void> saveShop(String apiEndpoint, String shopName, String shopContact) async {
    if (selectedRouteId != null) {
      final shop = Shop(
        shopName: shopName,
        shopContact: shopContact,
        routeId: int.parse(selectedRouteId!),
        isActive: isActive,
        createdBy: 2, // Assuming static values; adjust as needed
        updatedBy: 2,
      );

      await _shopService.saveShop(shop, apiEndpoint);
    }
  }
}
