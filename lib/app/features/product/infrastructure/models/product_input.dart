import 'package:dio/dio.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_state.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_variant.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_name.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_size.dart';
import 'package:http_parser/http_parser.dart';

class ProductInput {
  final List<ProductColorInput> productColors;
  final List<ProductSize> productSizes;
  final List<ProductVariant> variants;
  final ProductName name;

  ProductInput(
      {required this.productColors,
        required this.productSizes,
        required this.name,
        required this.variants});

  Future<Map<String, dynamic>> toJsonFormData() async {
    final productColorsMap = <String, dynamic>{};
    for (int i = 0; i < productColors.length; i++) {
      final productColor = productColors[i];
      final color = productColor.color;
      final images = productColor.images;
      productColorsMap.addAll({
        for (int j = 0; j < images.length; j++) ...{
          'productColors[$i][colorImages][$j]': MultipartFile.fromFileSync(
              images[j].path,
              contentType: MediaType('image', 'jpeg')),
        },
        'productColors[$i][colorName]': color.getOrCrash()
      });
    }
    final productSizesMap = <String, dynamic>{};

    for (int i = 0; i < productSizes.length; i++) {
      productSizesMap.addAll({
        'productSizes[$i]': productSizes[i].getOrCrash(),
      });
    }
    final productVariationMap = <String, dynamic>{};
    for (int i = 0; i < variants.length; i++) {
      final variant = variants[i];
      productVariationMap.addAll({
        'productVariations[$i][variantPrice]':
        variant.productPrice.getOrCrash(),
        'productVariations[$i][variantAttributes][variantSize]':
        variant.productSize.getOrCrash(),
        'productVariations[$i][variantAttributes][variantColor][colorName]':
        variant.productColor.getOrCrash(),
      });
    }
    final map = {
      'productName': name.getOrCrash(),
      ...productSizesMap,
      ...productColorsMap,
      ...productVariationMap
    };
    return (map);
  }
}