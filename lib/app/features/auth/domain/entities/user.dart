import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_email.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_full_name.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_password.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_token.dart';

class LoggedUser {
  final User user;
  final UserToken token;

  LoggedUser(this.user, this.token);
}

class User {
  final UserFullName name;
  final UserEmail email;
  final UserPassword password;

  User(this.name, this.email, this.password);
}

class Profile {
  final User user;

  Profile(this.user);
}