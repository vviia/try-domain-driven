import 'package:trying_to_not_crying/app/core/domain/failures/failure.dart';

class InvalidEmailOrPasswordFailure extends Failure {
  InvalidEmailOrPasswordFailure();
}

class EmailAlreadyExistsFailure extends Failure {
  EmailAlreadyExistsFailure();
}