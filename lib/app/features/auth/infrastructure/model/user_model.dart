import 'package:trying_to_not_crying/app/features/auth/domain/entities/user.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_email.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_full_name.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_password.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_token.dart';

class UserModel {
  final String name;
  final String email;
  final String password;

  UserModel(
      this.name,
      this.email,
      this.password,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['fullName'],
      json['email'],
      json['password'],
    );
  }

  User toDomain() {
    return User(
      UserFullName(name),
      UserEmail(email),
      UserPassword(password),
    );
  }
}

class LoggedUserModel {
  final UserModel user;
  final String token;

  LoggedUserModel(
      this.user,
      this.token,
      );

  factory LoggedUserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    return LoggedUserModel(
      UserModel.fromJson(user),
      json['token'],
    );
  }

  LoggedUser toDomain() {
    return LoggedUser(user.toDomain(), UserToken(token));
  }
}

class ProfileModel {
  final UserModel user;

  ProfileModel(this.user);

// from json
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return ProfileModel(UserModel.fromJson(user));
  }

  Profile toDomain() {
    return Profile(user.toDomain());
  }
}