import 'package:dartz/dartz.dart';
import 'package:trying_to_not_crying/app/core/domain/value_objects/value_object.dart';

class UserPassword extends ValueObject<String> {
  static Either<ValueFailure<String>, String> validate(String input) {
    if (input.length >= 6) {
      return right(input);
    } else {
      return left(ValueFailure());
    }
  }

  @override
  final Either<ValueFailure<String>, String> value;

  factory UserPassword(String input) {
    return UserPassword._(
      validate(input),
    );
  }

  const UserPassword._(this.value);
}