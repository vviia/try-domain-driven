import 'dart:io';

import 'package:trying_to_not_crying/app/features/product/infrastructure/models/product_input.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_state.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_color.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_entity.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_variant.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_color.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_name.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_price.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_size.dart';

class ProductMapper {
  ProductInput productInputFromState(ProductState state) {
    return ProductInput(
        productColors: state.productColors,
        productSizes: state.productSizes,
        name: state.name,
        variants: state.variants);
  }

  Product? fromJson(Map json) {
    final colorsAndSizes = json['productOptions'];
    final variantsJson = (json['productVariants'] as List);
    final variants = <ProductVariant>[];
    for (var i = 0; i < variantsJson.length; i++) {
      final e = variantsJson[i];
      final colorAndSize = e['variantAttributes'];
      if (colorAndSize == null || e['variantPrice'] == null) {
        return null;
      }
      ProductSize? size;
      try {
        size = ProductSize(colorAndSize['variantSize'] as String);
      } catch (e) {
        return null;
      }
      late ProductPrice variantPrice;

      final parsedPrice = num.tryParse(e['variantPrice']);
      if (parsedPrice == null) {
        return null;
      }
      variantPrice = ProductPrice(parsedPrice);

      variants.add(ProductVariant(
          productColor: ProductColorValueObject(
              colorAndSize['variantColor']['colorName']),
          productPrice: variantPrice,
          productSize: size));
    }
    return Product(
        productName: ProductName(json['productName']),
        id: json['_id'],
        productVariants: variants,
        productColors: (colorsAndSizes['productColors'] as List)
            .map((e) => ProductColor((e['colorImages'] as List).cast<String>(),
            ProductColorValueObject(e['colorName'])))
            .toList(),
        productSizes: (colorsAndSizes['productSizes'] as List)
            .map((e) => ProductSize(e))
            .toList());
  }
}