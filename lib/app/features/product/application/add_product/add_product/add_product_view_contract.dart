import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_price.dart';

abstract class AddProductViewContract {
  onAddProductSuccess();

  onAddProductFailed();

  onSuccessGenerateVariation();

  void onFormCleared();

  Future<ProductPrice?> showVariantPriceBottomSheet();

  void unFocusVariationPrice();
}