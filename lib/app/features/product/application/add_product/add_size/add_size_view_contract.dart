import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_size.dart';

abstract class AddSizeViewContract {
  onSizeAdded(ProductSize productSize);

  onFailed();
}