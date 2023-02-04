import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_entity.dart';
import 'package:trying_to_not_crying/app/features/product/application/all_products/all_product_state.dart';
import 'package:trying_to_not_crying/app/features/product/application/all_products/all_product_view_contract.dart';
import 'package:trying_to_not_crying/app/core/application/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../application/all_products/all_products_controller.dart';

class AllProductsView extends GetView<AllProductsController>
    implements AllProductViewContract {
  const AllProductsView({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() {
    // TODO: implement createElement
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
/*
    Get.find<AllProductsController>();
    controller.repo.getAll().then((value) => print('value: ${value.length()}'));
    return SizedBox();
*/
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: navigateToAddProduct,
        ),
        appBar: AppBar(
          title: const Text('HOME'),
          centerTitle: true,
        ),
        body: GetBuilder<AllProductsController>(builder: (logic) {
          final state = logic.state.allProductsDataState;
          if (state is AllProductsDataLoadingInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AllProductsDataFailure) {
            return Center(
              child: OutlinedButton(
                onPressed: ()=>controller.getAllProducts(),
                child: Text('Something went wrong click to retry'),
              ),
            );
          }
          if (state is AllProductsDataLoadingSuccess) {
            final products = state.products;
            return products.isEmpty
                ? Center(child: Text('Products are empty now.'))
                : GridView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.3)),
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return InkWell(
                  onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS,
                      arguments: product),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              enableInfiniteScroll: false,
                              height: 200.0,
                              viewportFraction: 1),
                          items: product.productColors[0].images.map((i) {
                            return CachedNetworkImage(
                              imageUrl: i,
                              fit: BoxFit.contain,
                              height: 20,
                            );
                          }).toList(),
                        ),
/*
                        CachedNetworkImage(
                          imageUrl: product.productColors[0].images[0],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
*/
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(product.productName.getOrCrash(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 30,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.productSizes.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              final e = product.productSizes[index];
                              return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                      BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 4),
                                    child: Center(
                                      child: Text(e.getOrCrash(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 5,
                              );
                            },
                          ),
                        ),
/*
                        ...product.productSizes
                            .map((e) => Container(
                            color: Colors.grey,
                            child: Text(e.getOrCrash(),
                                style: const TextStyle(
                                  color: Colors.white,
                                    ))))
                            .toList(),
*/
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox();
        }));
  }

  @override
  Future<Product?> navigateToAddProduct() async {
    final product = await Get.toNamed(Routes.ADD_PRODUCT);
    return product;
  }

  @override
  onAddProductFailed() {
    // TODO: implement onAddProductFailed
    throw UnimplementedError();
  }

  @override
  onAddProductSuccess() {
    // TODO: implement onAddProductSuccess
    throw UnimplementedError();
  }

  @override
  onSuccessAddVariation() {
    // TODO: implement onSuccessAddVariation
    throw UnimplementedError();
  }
}