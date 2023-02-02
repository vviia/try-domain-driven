import 'package:dartz/dartz.dart';
// import 'package:trying_to_not_crying/app/core/domain/value_objects/valune_object.dart';
import 'package:trying_to_not_crying/app/core/domain/value_objects/value_object.dart';
import 'package:email_validator/email_validator.dart';

class UserEmail extends ValueObject<String> {
  static Either<ValueFailure<String>, String> validate(String input) {
    if (EmailValidator.validate(input)) {
      return right(input);
    } else {
      return left(ValueFailure());
    }
  }

  @override
  final Either<ValueFailure<String>, String> value;

  /* factory UserEmail.parse(String input) {
    return UserEmail._(
        ,
    );
  }*/

  factory UserEmail(String input) {
    return UserEmail._(
      validate(input),
    );
  }

  const UserEmail._(this.value);
}