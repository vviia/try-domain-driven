import 'package:trying_to_not_crying/app/core/domain/failures/failure.dart';

abstract class ProfileViewContract{
  void onLogoutSuccess();
  void onLogoutFailed(Failure failure);
}