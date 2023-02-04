import 'package:dartz/dartz.dart';
import 'package:trying_to_not_crying/app/core/domain/value_objects/value_object.dart';

class ProductName extends ValueObject<String> {
  static Either<ValueFailure<String>, String> validate(String input) {
    if (input.isNotEmpty) {
      return right(input);
    } else {
      return left(ValueFailure());
    }
  }

  @override
  final Either<ValueFailure<String>, String> value;

  factory ProductName(String input) {
    return ProductName._(
      validate(input),
    );
  }
  factory ProductName.parse(String input) {
    return ProductName._(
      right(input),
    );
  }

  const ProductName._(this.value);
}