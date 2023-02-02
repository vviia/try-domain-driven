import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_color.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_repo.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_events.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_state.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_view_contract.dart';
import 'package:get/get.dart';

class AddColorController extends GetxController implements AddColorEvents {
  AddColorState state;
  final AddProductRepo addProductRepo;
  late final AddColorViewContract addColorViewContract;

  AddColorController(this.state, this.addProductRepo);

  @override
  void onChangedColorTextField(ProductColorValueObject color) {
    state =
        state.copyWith(productColor: state.productColor.copyWith(color: color));
  }

  @override
  Future<void> onPickImages() async {
    final result = await addProductRepo.pickMultiImage();
    state = state.copyWith(
      productColor: state.productColor.copyWith(images: result),
    );
    update();

  }

  @override
  void onAddColor() {
    addColorViewContract.onColorAdded(state.productColor);
    state = state.copyWith(productColor: ProductColorInput.initial());
    update();
  }
}