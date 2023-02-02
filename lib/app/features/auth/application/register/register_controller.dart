import 'package:trying_to_not_crying/app/features/auth/application/register/register_state.dart';
import 'package:trying_to_not_crying/app/features/auth/application/register/register_view_contract.dart';
import 'package:trying_to_not_crying/app/features/auth/application/register/register_events.dart';
import 'package:trying_to_not_crying/ommerce_crud_operation/app/features/auth/domain/repository/auth_repo.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_email.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_full_name.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/value_objects/user_password.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController implements RegisterEvents {
  final AuthRepo repo;
  RegisterState state;
  late final RegisterViewContract view;

  RegisterController(this.repo, this.state);

  @override
  void onChangeEmailTextField(UserEmail email) {
    state = state.copyWith(
      email: email,
    );
  }

  @override
  void onChangePasswordTextField(UserPassword password) {
    state = state.copyWith(
      password: password,
    );
  }

  @override
  void onChangeNameTextField(UserFullName fullName) {
    state = state.copyWith(
      fullName: fullName,
    );
  }

  @override
  Future<void> onTapRegisterButton() async {
    final isValid = view.validateForm();
    if (!isValid) return;
    final email = state.email;
    final password = state.password;
    final name = state.fullName;

    final result = await repo.register(name, password, email);
    print(result);
    result.fold(view.onFailed, (r) => view.onSuccess());
  }
}