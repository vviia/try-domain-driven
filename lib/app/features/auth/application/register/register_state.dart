import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_email.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_full_name.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_password.dart';

class RegisterState {
  final UserEmail email;
  final UserPassword password;
  final UserFullName fullName;

  RegisterState(
      {required this.email, required this.fullName, required this.password});

  // copy with
  RegisterState copyWith(
      {UserEmail? email, UserPassword? password, UserFullName? fullName}) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
    );
  }

  // initial
  factory RegisterState.initial() {
    return RegisterState(
      email: UserEmail(''),
      password: UserPassword(''),
      fullName: UserFullName(''),
    );
  }
}