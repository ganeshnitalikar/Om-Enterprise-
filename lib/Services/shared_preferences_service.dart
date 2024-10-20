import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late final SharedPreferences _sharedPrefs;

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  setRouteId(int routeId) {
    _sharedPrefs.setInt('routeId', routeId);
  }

  setToken(String token) {
    _sharedPrefs.setString('token', token);
  }

  setEmployeeId(int employeeId) {
    _sharedPrefs.setInt('employeeId', employeeId);
  }

  setemployeeRole(String employeeRole) {
    _sharedPrefs.setString('employeeRole', employeeRole);
  }

  int getRouteId() {
    return _sharedPrefs.getInt('routeId') ?? 0;
  }
}

final sharedPrefs = SharedPrefs();
