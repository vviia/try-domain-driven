import 'dart:io';

import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_color.dart';

class ProductColorInput {
  final List<File> images;
  final ProductColorValueObject color;

  ProductColorInput({required this.images, required this.color});

  // initial
  factory ProductColorInput.initial() {
    return ProductColorInput(images: [], color: ProductColorValueObject(''));
  }

  // copy with optional
  ProductColorInput copyWith(
      {List<File>? images, ProductColorValueObject? color}) {
    return ProductColorInput(
        images: images ?? this.images, color: color ?? this.color);
  }
}

class AddColorState {
  final ProductColorInput productColor;

  AddColorState(
      this.productColor,
      );

  // copy with
  AddColorState copyWith({
    ProductColorInput? productColor,
  }) {
    return AddColorState(
      productColor ?? this.productColor,
    );
  }

  // initial state
  factory AddColorState.initial() {
    return AddColorState(
      ProductColorInput.initial(),
    );
  }
}