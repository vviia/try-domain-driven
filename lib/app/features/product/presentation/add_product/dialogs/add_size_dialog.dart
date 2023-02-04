import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_size.dart';
import 'package:trying_to_not_crying/app/core/presentation/widgets/product_sizes_list.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_controller.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_size/add_size_controller.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_size/add_size_view_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSizeDialog extends GetView<AddSizeController>
    implements AddSizeViewContract {
  AddSizeDialog({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.viewContract = this;
    return StatelessElement(this);
  }

  final textEditingController = TextEditingController();

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
                  decoration: const InputDecoration(
                    labelText: 'Size',
                  ),
                  controller: textEditingController,
                  onChanged: (_) =>
                      controller.onChangeSizeTextField(ProductSize(_)),
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.onTapAddSizeButton();
                    },
                    child: Text('Done'))
              ],
            ),
          )),
    );
  }

  @override
  onFailed() {
    Get.snackbar('Error', 'Failed to add product');
  }

  @override
  onSizeAdded(ProductSize productSize) {
    Get.find<AddProductController>().addSize(productSize);
    textEditingController.clear();
  }
}