import 'package:dio/dio.dart';
import '../../Model/Admin/shop.dart';

class ShopService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchRoutes(String apiEndpoint) async {
    try {
      final response = await _dio.get(apiEndpoint);
      return response.data['result']; // Adjust according to your API response structure
    } catch (e) {
      print("Error fetching routes: $e");
      throw Exception('Failed to load routes');
    }
  }

  Future<void> saveShop(Shop shop, String apiEndpoint) async {
    try {
      await _dio.post(apiEndpoint, data: shop.toJson());
    } catch (e) {
      print("Error saving shop: $e");
      throw Exception('Failed to save shop');
    }
  }
}
