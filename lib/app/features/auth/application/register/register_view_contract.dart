import 'package:trying_to_not_crying/app/core/domain/failures/failure.dart';

abstract class RegisterViewContract {
  onSuccess();

  onFailed(Failure failure);

  bool validateForm();
}