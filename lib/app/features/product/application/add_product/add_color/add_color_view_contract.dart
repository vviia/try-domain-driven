import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_state.dart';

abstract class AddColorViewContract {
  onColorAdded(ProductColorInput productColorInput);

  onFailed();
}