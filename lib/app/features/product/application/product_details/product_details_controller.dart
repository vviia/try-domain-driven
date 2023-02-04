import 'package:trying_to_not_crying/app/features/product/domain/entities/product_color.dart';
import 'package:trying_to_not_crying/app/features/product/application/product_details/product_details_events.dart';
import 'package:trying_to_not_crying/app/features/product/application/product_details/product_details_state.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController
    implements ProductDetailsEvents {
  ProductDetailsState state;

  ProductDetailsController(this.state);

  @override
  void onSelectColor(int index) {
    state = state.copyWith(
      selectedColorIndex: index,
    );
    update();
    // update(['color']);
  }

  @override
  void onSelectSize(int index) {
    state = state.copyWith(selectedSizeIndex: index);
    update();
  }
}