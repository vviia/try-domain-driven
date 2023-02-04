import 'package:dartz/dartz.dart';
import 'package:trying_to_not_crying/app/core/domain/failures/failure.dart';
import 'package:trying_to_not_crying/app/features/product/infrastructure/models/product_input.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<Product>>> getAll();

  Future<Either<Failure, Unit>> add(ProductInput product);
}