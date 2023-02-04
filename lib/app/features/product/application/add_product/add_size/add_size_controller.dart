import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_size.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_controller.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_size/add_size_events.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_size/add_size_view_contract.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_size/add_size_state.dart';
import 'package:get/get.dart';

class AddSizeController extends GetxController implements AddSizeEvents {
  AddSizeState state;
  late final AddSizeViewContract viewContract;

  AddSizeController(
      this.state,
      );

  @override
  void onTapAddSizeButton() {
    viewContract.onSizeAdded(state.size);
    state = AddSizeState.initial();
  }

  @override
  void onChangeSizeTextField(ProductSize size) {
    state = state.copyWith(size: size);
  }
}