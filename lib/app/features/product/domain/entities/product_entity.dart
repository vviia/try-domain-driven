import 'package:trying_to_not_crying/app/features/product/domain/entities/product_color.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_variant.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_name.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_size.dart';

class Product {
  final String id;
  final List<ProductVariant> productVariants;
  final List<ProductColor> productColors;
  final List<ProductSize> productSizes;
  final ProductName productName;

  Product(
      {required this.id,
        required this.productVariants,
        required this.productColors,
        required this.productSizes,
        required this.productName});

  // copy with
  Product copyWith({
    String? id,
    List<String>? images,
    List<ProductVariant>? productVariants,
    List<ProductColor>? productColors,
    List<ProductSize>? productSizes,
    ProductName? productName,
  }) {
    return Product(
      id: id ?? this.id,
      productVariants: productVariants ?? this.productVariants,
      productColors: productColors ?? this.productColors,
      productSizes: productSizes ?? this.productSizes,
      productName: productName ?? this.productName,
    );
  }

  // initial state
  factory Product.initial() {
    return Product(
        id: '',
        productVariants: [],
        productColors: [],
        productSizes: [],
        productName: ProductName(''));
  }
}