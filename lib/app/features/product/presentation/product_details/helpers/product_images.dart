import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_entity.dart';
import 'package:trying_to_not_crying/app/features/product/application/product_details/product_details_controller.dart';
import 'package:trying_to_not_crying/app/features/product/presentation/product_details/helpers/size_config.dart';
import 'package:trying_to_not_crying/app/features/product/presentation/product_details/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  final controller = Get.find<ProductDetailsController>();

  @override
  Widget build(BuildContext context) {
    print(widget.product.productColors);
    print(widget.product.productVariants[0]);
    print(widget.product.productVariants[0]);
    return Column(
      children: [
        GetBuilder<ProductDetailsController>(builder: (logic) {
          return CarouselSlider(
            options: CarouselOptions(height: 300.0, viewportFraction: 1),
            items: widget
                .product.productColors[controller.state.selectedColor].images
                .map((i) {
              return CachedNetworkImage(
                imageUrl: i,
                fit: BoxFit.cover,
              );
            }).toList(),
          );
        }),

        GetBuilder<ProductDetailsController>(builder: (logic) {
          return SizedBox(
            height: 80,

            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget
                  .product.productColors[controller.state.selectedColor].images
                  .map((e) => SizedBox(
                width: 80,
                child: buildSmallProductPreview(e),))
                  .toList(),
            ),
          );
        })
      ],
    );
  }

  Widget buildSmallProductPreview(String image) {
    // print(index);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CachedNetworkImage(imageUrl: image, fit: BoxFit.cover,),
    );
  }
}