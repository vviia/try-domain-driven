import 'package:internet_connection_checker/internet_connection_checker.dart';

class DeviceConnectionChecker {
  final InternetConnectionChecker checker;

  DeviceConnectionChecker(this.checker);

  Future<bool> hasConnection() {
    return checker.hasConnection;
  }
}