import 'package:trying_to_not_crying/app/features/product/domain/entities/product_color.dart';

abstract class ProductDetailsEvents {
  void onSelectSize(int index);

  void onSelectColor(int index);
}