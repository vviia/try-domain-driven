import 'package:dartz/dartz.dart';
import 'package:trying_to_not_crying/app/core/domain/value_objects/value_object.dart';
import 'package:email_validator/email_validator.dart';

class UserToken extends ValueObject<String> {
  static Either<ValueFailure<String>, String> validate(String input) {
    return right(input);
  }

  @override
  final Either<ValueFailure<String>, String> value;

  factory UserToken(String input) {
    return UserToken._(
      validate(input),
    );
  }

  const UserToken._(this.value);
}