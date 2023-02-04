import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_state.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_variant.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_name.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_price.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_size.dart';

class ProductState {
  final List<ProductColorInput> productColors;
  final List<ProductSize> productSizes;
  final int selectedColorIndex;
  final int selectedSizeIndex;
  List<ProductVariant> variants;
  final bool isLoading;
  ProductPrice? price;
  final ProductName name;

  ProductState(this.productColors, this.selectedColorIndex, this.productSizes,
      this.selectedSizeIndex, this.variants, this.name, this.isLoading,
      {this.price});

  // copy with
  ProductState copyWith({
    List<ProductColorInput>? productColors,
    int? selectedColorIndex,
    List<ProductSize>? productSizes,
    int? selectedSizeIndex,
    ProductPrice? price,
    List<ProductVariant>? variants,
    ProductName? name,
    bool? isLoading,
  }) {
    return ProductState(
      productColors ?? this.productColors,
      selectedColorIndex ?? this.selectedColorIndex,
      productSizes ?? this.productSizes,
      selectedSizeIndex ?? this.selectedSizeIndex,
      variants ?? this.variants,
      name ?? this.name,
      isLoading ?? this.isLoading,
      price: price ?? this.price,
    );
  }

  ProductState addColor(ProductColorInput productColor) {
    return copyWith(
      productColors: [...productColors, productColor],
    );
  }

  ProductState reset() {
    return copyWith(
      price: null,
      selectedColorIndex: -1,
      selectedSizeIndex: -1,
    );
  }

  ProductState addVariant() {
    return copyWith(
      variants: [
        ...variants,
        ProductVariant(
            productColor: productColors[selectedColorIndex].color,
            productSize: productSizes[selectedSizeIndex],
            productPrice: price!)
      ],
    );
  }

  ProductState addSize(ProductSize productSize) {
    return copyWith(
      productSizes: [...productSizes, productSize],
    );
  }
  factory ProductState.initial() {
    return ProductState([], -1, [], -1, [], ProductName(''), false);
  }
}