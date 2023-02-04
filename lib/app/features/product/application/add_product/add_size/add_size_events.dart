import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_size.dart';

abstract class AddSizeEvents {
  void onTapAddSizeButton();

  void onChangeSizeTextField(ProductSize text);
}