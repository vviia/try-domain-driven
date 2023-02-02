import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trying_to_not_crying/app/core/infrastructure/exception/exception.dart';
import 'package:trying_to_not_crying/app/core/domain/failures/failure.dart';
import 'package:trying_to_not_crying/app/features/auth/infrastructure/exceptions/exceptions.dart';
import 'package:trying_to_not_crying/app/features/auth/infrastructure/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoggedUserModel> login(String email, String phone);

  Future<void> register(String name, String email, String password);

  Future<ProfileModel> getProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<LoggedUserModel> login(String email, String password) async {
    try {
      print('email: $email password: $password');
      final dioResult = await dio
          .post('/login-user', data: {"email": email, "password": password});
      final data = dioResult.data;
      return LoggedUserModel.fromJson(data);
    } on DioError catch (e) {
      final response = e.response!;
      if (response.statusCode == 400) {
        throw InvalidEmailOrPasswordException();
      }
      throw ServerException();
    } catch (e) {
      throw UnExcepectedException();
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.post('/register-user',
          data: (({"fullName": name, "email": email, "password": password})));
    } on DioError catch (e) {
      final response = e.response!;
      if (response.statusCode == 400) {
        throw EmailAlreadyExistsException();
      }
      throw ServerException();
    } catch (e) {
      throw UnExcepectedException();
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final dioResult = await dio.get(
        '/get-user-info',
      );
      return ProfileModel.fromJson(dioResult.data);
    } on DioError catch (e) {
      throw ServerException();
    } catch (e) {
      throw UnExcepectedException();
    }
  }
}