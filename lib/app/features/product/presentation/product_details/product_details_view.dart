import 'package:trying_to_not_crying/app/features/product/domain/entities/product_entity.dart';
import 'package:trying_to_not_crying/app/features/product/presentation/product_details/helpers/product_images.dart';
import 'package:trying_to_not_crying/app/features/product/presentation/product_details/helpers/size_config.dart';
import 'package:trying_to_not_crying/app/features/product/presentation/product_details/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../application/product_details/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = controller.state.product;

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
/*
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: BackButton(color: Colors.black)),
*/
            ProductImages(product: product),
            const SizedBox(height: defaultPadding * 1.5),
            Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding,
                  defaultPadding * 2, defaultPadding, defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadius * 3),
                  topRight: Radius.circular(defaultBorderRadius * 3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.productName.getOrCrash(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      if (controller.state.selectedVariant == null)
                        SizedBox()
                      else
                        GetBuilder<ProductDetailsController>(builder: (logic) {
                          return Text(
                            "\$" +
                                logic.state.selectedVariant!.productPrice
                                    .getOrCrash()
                                    .toString(),
                            style: Theme.of(context).textTheme.headline6,
                          );
                        }),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    "Sizes",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(
                    height: 80,
                    child:
                    GetBuilder<ProductDetailsController>(builder: (logic) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.productSizes.length,
                        itemBuilder: (BuildContext context, int index) {
                          final size = product.productSizes[index];
                          print(size == size);
                          return VariationCard(
                            text: size.getOrCrash(),
                            isSelected:
                            controller.state.selectedSizeIndex == index,
                            onTap: () => controller.onSelectSize(index),
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Text(
                    "Colors",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(
                    height: 80,
                    child:
                    GetBuilder<ProductDetailsController>(builder: (logic) {
                      return ListView.builder(
                        itemExtent: 80,
                        scrollDirection: Axis.horizontal,
                        itemCount: product.productColors.length,
                        itemBuilder: (BuildContext context, int index) {
                          final color = product.productColors[index];
                          return VariationCard(
                            text: color.color.getOrCrash(),
                            isSelected: controller.state.selectedColor == index,
                            onTap: () => controller.onSelectColor(index),
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VariationCard extends StatelessWidget {
  const VariationCard(
      {Key? key,
        required this.text,
        required this.onTap,
        required this.isSelected})
      : super(key: key);
  final bool isSelected;
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: isSelected ? Get.theme.primaryColor : Colors.white,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                text,
                style: TextStyle(
                    color: !isSelected ? Get.theme.primaryColor : Colors.white,
                    fontSize: 20),
              ),
            )),
      ),
    );
  }
}