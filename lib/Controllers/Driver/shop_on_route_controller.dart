// shop.dart
import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:om/Model/driver_shop_model.dart';
import 'package:om/Services/shared_preferences_service.dart';

class ShopOnRouteController extends GetxController {
  var shops = <DriverShop>[].obs; // Observable list of shops
  var isLoading = true.obs; // Observable for loading state

  @override
  void onReady() {
    super.onReady();
    fetchShops();
  }

  Future<void> fetchShops() async {
    const url =
        'http://139.59.7.147:7071/driverOperations/getRouteWiseEmployeeSale';
    final headers = {
      'Content-Type': 'application/json',
      'accept': '*/*',
    };
    final body = jsonEncode({
      "assignVehicleId": {"id": sharedPrefs.getAssignId()},
      "routeId": {"id": sharedPrefs.getRouteId()},
      "employeeId": {"id": sharedPrefs.getEmpId()},
    });

    try {
      isLoading(true); // Set loading to true
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final resultList = data['result'] as List;
        shops.value = resultList
            .map((shopJson) => DriverShop.fromJson(shopJson))
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch shops');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch shops: $e');
    } finally {
      isLoading(false); // Set loading to false
    }
  }
}
