import 'package:dartz/dartz.dart';
import 'package:trying_to_not_crying/app/core/domain/value_objects/value_object.dart';

class ProductSize extends ValueObject<String> {
  static Either<ValueFailure<String>, String> validate(String input) {
    if (input.isNotEmpty) {
      return right(input);
    } else {
      return left(ValueFailure());
    }
  }

  @override
  final Either<ValueFailure<String>, String> value;

  factory ProductSize(String input) {
    return ProductSize._(
      validate(input),
    );
  }

  // copy with
  ProductSize copyWith(String color) {
    return ProductSize(color);
  }

  const ProductSize._(this.value);
}