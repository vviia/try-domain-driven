import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  String? getToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final GetStorage _storage;
  final String _key = 'token';

  AuthLocalDataSourceImpl(this._storage);

  Future<void> saveToken(String token) async {
    await _storage.write(_key, token);
  }

  String? getToken() {
    return _storage.read(_key);
  }

  @override
  Future<void> deleteToken() async {
    return _storage.remove(_key);
  }
}