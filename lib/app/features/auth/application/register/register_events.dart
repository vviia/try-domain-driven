import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_color.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_email.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_full_name.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_password.dart';

abstract class RegisterEvents {
  void onChangeEmailTextField(UserEmail email);

  void onChangePasswordTextField(UserPassword password);

  void onChangeNameTextField(UserFullName fullName);

  void onTapRegisterButton();
}