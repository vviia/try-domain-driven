import 'package:trying_to_not_crying/app/core/presentation/widgets/product_colors_list.dart';
import 'package:trying_to_not_crying/app/core/presentation/widgets/product_sizes_list.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_controller.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_view_contract.dart';
import 'package:trying_to_not_crying/app/features/product/application/all_products/all_products_controller.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_name.dart';
import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_price.dart';
import 'package:trying_to_not_crying/app/features/product/presentation/add_product/dialogs/add_color_dialog.dart';
import 'package:trying_to_not_crying/app/features/product/presentation/add_product/dialogs/add_size_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddProductView extends GetView<AddProductController>
    implements AddProductViewContract {
  AddProductView({Key? key}) : super(key: key);

  // create element
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  StatelessElement createElement() {
    controller.viewContract = this;
    return StatelessElement(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<AllProductsController>().getAllProducts();
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.onTapAddProductButton();
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        appBar: AppBar(
          title: const Text('Add Product'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                  ),
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  onChanged: (x) => controller.onNameTextFieldChanged(ProductName((x))),
                ),
                OutlinedButton(
                    onPressed: () {
                      Get.bottomSheet(AddColorDialog());
                    },
                    child: Text('Add Color')),
                GetBuilder<AddProductController>(builder: (logic) {
                  return ProductColorList(
                    selectedIndex: controller.state.selectedColorIndex,
                    colors: controller.state.productColors.toList(),
                    onTap: (x){},
                  );
                }),
                OutlinedButton(
                    onPressed: () {
                      Get.bottomSheet(AddSizeDialog());
                    },
                    child: Text('Add Size')),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    height: 80,
                    child: GetBuilder<AddProductController>(builder: (logic) {
                      final state = logic.state;
                      final sizes = state.productSizes;
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: sizes.length,
                        itemBuilder: (BuildContext context, int index) {
                          final size = sizes[index];
                          return VariationCard(
                            text: size.getOrCrash(),
                            onTap: () {
                              controller.onTapSizeCard(index);
                            },
                            isSelected: state.selectedSizeIndex == index,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 10);
                        },
                      );
                    }),
                  ),
                ),
                OutlinedButton(
                    onPressed: () async {
                      controller.onTapGenerateVariationButton();
                    },
                    child: Text('Generate Variation')),
                SizedBox(
                  height: 80,
                  child: GetBuilder<AddProductController>(builder: (logic) {
                    final state = logic.state;
                    final variants = state.variants;
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: variants.length,
                      itemBuilder: (BuildContext context, int index) {
                        final variant = variants[index];
                        return VariationCard(
                          text: variant.productSize.getOrCrash() +
                              '\n' +
                              variant.productPrice.getOrCrash().toString() +
                              ' EGP'
                                  '\n' +
                              variant.productColor.getOrCrash(),
                          onTap: () {
                            controller.onTapVariantCard(index);
                          },
                          isSelected: false,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 10);
                      },
                    );
                  }),
                ),
                OutlinedButton(
                    onPressed: () async {
                      controller.onTapClearButton();
                    },
                    child: Text('Clear')),
              ],
            ),
          ),
          // Use Material color picker:
          //
        ),
      ),
    );
  }

  @override
  onAddProductFailed() {
    Get.snackbar('Error', 'Failed to add product');
  }

  @override
  onSuccessGenerateVariation() {
    Get.snackbar('Success', 'Variation Generated');
  }

  @override
  onAddProductSuccess() {
    Get.snackbar('Success', 'Product added successfully');
  }

  @override
  Future<ProductPrice?> showVariantPriceBottomSheet() async {
    return Get.bottomSheet(VariationPriceBottomSheet());
  }

  @override
  void unFocusVariationPrice() {}

  @override
  void onFormCleared() {
    nameController.clear();
  }
}

class VariationPriceBottomSheet extends StatelessWidget {
  VariationPriceBottomSheet({Key? key}) : super(key: key);
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Variation Price',
                ),
                focusNode: focusNode,
                controller: controller,
              ),
              OutlinedButton(
                  onPressed: () {
                    focusNode.unfocus();
                    Get.back(result: ProductPrice(num.parse(controller.text)));
                  },
                  child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}