import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_repo.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_state.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_events.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_state.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_view_contract.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_variant.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_name.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_price.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_size.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController implements AddProductEvents {
  final AddProductRepo repo;
  ProductState state;
  late final AddProductViewContract viewContract;

  AddProductController(this.state, this.repo);


  void addColor(ProductColorInput? color) {
    if (color != null) {
      state = state.addColor(color);
      update();
    }
  }

  void addSize(ProductSize? size) {
    if (size != null) {
      state = state.addSize(size);
      update();
    }
  }

  @override
  Future<void> onTapSizeCard(int index) async {
    final price = await viewContract.showVariantPriceBottomSheet();
    final selectedSize = state.productSizes[index];

    for (int i = 0; i < state.variants.length; i++) {
      if (state.variants[i].productSize == selectedSize) {
        state.variants[i] = state.variants[i].copyWith(productPrice: price);
        update();
      }
    }
  }

  @override
  void onPriceChanged(ProductPrice price) {
    state = state.copyWith(price: price);
  }

  @override
  void onTapGenerateVariationButton() {
    state = state.reset();
    final colors = state.productColors;
    final sizes = state.productSizes;
    final variants = <ProductVariant>[];
    for (var i = 0; i < colors.length; i++) {
      for (var j = 0; j < sizes.length; j++) {
        variants.add(ProductVariant(
            productColor: colors[i].color,
            productSize: sizes[j],
            productPrice: ProductPrice(0)));
      }
    }
    state = state.copyWith(variants: variants);
    update();
  }

  @override
  void onNameTextFieldChanged(ProductName name) {
    state = state.copyWith(name: name);
  }

  @override
  Future<void> onTapAddProductButton() async {
    final result = await repo.add(state);
    result.fold((l) {
      viewContract.onAddProductFailed();
    }, (r) {
      viewContract.onAddProductSuccess();
    });
  }

  @override
  Future<void> onTapVariantCard(int index) async {
    final price = await viewContract.showVariantPriceBottomSheet();
    state.variants[index] = state.variants[index].copyWith(productPrice: price);
    update();
  }

  void onTapClearButton() {
    state = ProductState.initial();
    update();
  }
}