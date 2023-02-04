import 'package:trying_to_not_crying/app/features/product/domain/entities/product_entity.dart';

abstract class AllProductViewContract {
  onAddProductSuccess();

  onAddProductFailed();

  onSuccessAddVariation();

  Future<Product?> navigateToAddProduct();
}