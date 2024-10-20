import 'package:dio/dio.dart';
import '../../Model/Admin/route_model.dart';

class RouteService {
  final Dio _dio = Dio();

  Future<void> saveRoute(RouteModel route) async {
    const apiUrl = 'http://139.59.7.147:7071/masters/saveRoute';
    final response = await _dio.post(apiUrl, data: route.toJson());
    return response.data;
  }
}
