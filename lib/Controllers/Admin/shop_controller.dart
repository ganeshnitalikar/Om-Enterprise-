import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om/Api%20Service/Admin/Api.dart';
import '../../Model/Admin/shop.dart';

class ShopController extends GetxController {
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopContactController = TextEditingController();
  String? selectedRouteId;
  bool isActive = false;
  List<dynamic> routes = [];
   final api=new ApiClass();

  @override
  void onInit() {
    super.onInit();
    fetchRoutes();
  }

   @override
  void onClose() {
    // Dispose of the TextEditingControllers when the controller is closed
    shopNameController.dispose();
    shopContactController.dispose();
    super.onClose();
  }

  Future<void> fetchRoutes() async {
    try {
      routes = await api.fetchRoutes();
      update(); // Notify listeners about the change
    } catch (e) {
      Get.snackbar('Error', 'Error fetching routes: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> saveShop() async {
    final String shopName = shopNameController.text;
    final String shopContact = shopContactController.text;

    if (shopName.isNotEmpty &&
        shopContact.isNotEmpty &&
        selectedRouteId != null) {
      final shop = Shop(
        shopName: shopName,
        shopContact: shopContact,
        routeId: int.parse(selectedRouteId!),
        isActive: isActive,
        createdBy: 2,
        updatedBy: 2,
      );

      try {
        await api.saveShop(
            shop, 'http://139.59.7.147:7071/masters/saveShop');
        Get.snackbar('Success', 'Shop saved successfully!',
            snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        Get.snackbar('Error', 'Error saving shop: $e',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Warning', 'Please fill all fields.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
