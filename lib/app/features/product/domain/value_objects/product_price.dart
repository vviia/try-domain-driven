import 'package:dartz/dartz.dart';
import 'package:trying_to_not_crying/app/core/domain/value_objects/value_object.dart';

class ProductPrice extends ValueObject<num> {
  static Either<ValueFailure<String>, num> validate(num input) {
    if (input >= 0) {
      return right(input);
    }
    return left(ValueFailure());
  }

  @override
  final Either<ValueFailure<String>, num> value;

  factory ProductPrice(num input) {
    return ProductPrice._(
      validate(input),
    );
  }

  const ProductPrice._(this.value);
}