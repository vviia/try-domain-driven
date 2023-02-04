import 'package:collection/collection.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_color.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_entity.dart';

import '../../domain/entities/product_variant.dart';

class ProductDetailsState {
  final int selectedSizeIndex, selectedColor;
  final Product product;

  ProductVariant? get selectedVariant {
    final color = product.productColors[selectedColor];
    final size = product.productSizes[selectedSizeIndex];
    return product.productVariants.singleWhereOrNull(
          (element) =>
      element.productColor == color.color && element.productSize == size,
    );
  }

  ProductDetailsState(
      {required this.selectedSizeIndex,
        required this.selectedColor,
        required this.product});

  // copy with
  ProductDetailsState copyWith({
    int? selectedSizeIndex,
    int? selectedColorIndex,
    Product? product,
  }) {
    return ProductDetailsState(
      selectedSizeIndex: selectedSizeIndex ?? this.selectedSizeIndex,
      selectedColor: selectedColorIndex ?? this.selectedColor,
      product: product ?? this.product,
    );
  }

  factory ProductDetailsState.initial(Product product) {
    return ProductDetailsState(
        selectedSizeIndex: 0, selectedColor: 0, product: product);
  }
}