import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_color.dart';

abstract class AddColorEvents {
  void onPickImages();

  void onChangedColorTextField(ProductColorValueObject color);

  void onAddColor();
}