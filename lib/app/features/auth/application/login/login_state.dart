import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_email.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_password.dart';

class LoginState {
  final UserEmail email;
  final UserPassword password;

  LoginState({required this.email, required this.password});

  // copy with
  LoginState copyWith({UserEmail? email, UserPassword? password}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  // initial
  factory LoginState.initial() {
    return LoginState(
      email: UserEmail(''),
      password: UserPassword(''),
    );
  }
}