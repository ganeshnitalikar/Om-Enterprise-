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

  setUsername(String username) {
    _sharedPrefs.setString('username', username);
  }

  setAssignId(int assignId) {
    _sharedPrefs.setInt('assignId', assignId);
  }

  setEmployeeName(String employeeName) {
    _sharedPrefs.setString('employeeName', employeeName);
  }

  String getEmployeeName() {
    return _sharedPrefs.getString('employeeName') ?? '';
  }

  int getEmpId() {
    return _sharedPrefs.getInt('employeeId') ?? 0;
  }

  int getAssignId() {
    return _sharedPrefs.getInt('assignId') ?? 0;
  }

  String getusername() {
    return _sharedPrefs.getString('username') ?? '';
  }

  int getRouteId() {
    return _sharedPrefs.getInt('routeId') ?? 0;
  }

  String? getToken() {
    return _sharedPrefs.getString('token');
  }

  String? getEmployeeRole() {
    return _sharedPrefs.getString('employeeRole');
  }

  Future<void> clearPreferences() async {
    await _sharedPrefs.clear();
  }
}

final sharedPrefs = SharedPrefs();
