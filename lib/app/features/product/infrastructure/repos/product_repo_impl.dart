import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trying_to_not_crying/app/core/domain/failures/failure.dart';
import 'package:trying_to_not_crying/app/features/product/infrastructure/mappers/add_product_mapper.dart';
import 'package:trying_to_not_crying/app/features/product/infrastructure/models/product_input.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_entity.dart';
import 'package:trying_to_not_crying/app/features/product/domain/repository/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  ProductRepoImpl(this._dio);

  final Dio _dio;

  @override
  Future<Either<Failure, Unit>> add(ProductInput product) async {
    try {
      final body = await product.toJsonFormData();
      final result = await _dio.post('/add-product',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: FormData.fromMap(body));

      return right(unit);
    } catch (e) {
      return left(UnExpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAll() async {
    try {
      final result = await _dio.get(
        '/get-all-products',
      );
      final mapper = ProductMapper();
      final List resultData = result.data['products'];
      print(resultData.length);
      final products = <Product>[];
      for (int i = 0; i < resultData.length; i++) {
        final e = resultData[i];

        final product = mapper.fromJson(e);
        print('product: ${product}');

        if (product != null) {
          products.add(product);
        }
        print('products: ${products.length}');
      }
      return right(products.reversed.toList());
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return right([]);
      }
      return left(ServerFailure());
    } catch (e) {
      return left(UnExpectedFailure());
    }
  }
}