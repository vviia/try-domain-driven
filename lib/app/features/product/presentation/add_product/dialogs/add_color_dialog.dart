import 'package:trying_to_not_crying/app/features/product/domain/value_objects/product_color.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_controller.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_state.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_view_contract.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddColorDialog extends GetView<AddColorController>
    implements AddColorViewContract {
  AddColorDialog({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.addColorViewContract = this;

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
                    labelText: 'Color Name',
                  ),
                  controller: textEditingController,
                  onChanged: (value) {
                    controller
                        .onChangedColorTextField(
                        ProductColorValueObject(value));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<AddColorController>(builder: (logic) {
                    return Wrap(
                        children: controller.state.productColor.images
                            .map((e) =>
                            Image.file(
                              e,
                              height: 50,
                              width: 50,
                            ))
                            .toList());
                  }),
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.onPickImages();
                    },
                    child: Text('Select images')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green),

                    onPressed: () {
                      controller.onAddColor();
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
  onColorAdded(ProductColorInput productColorInput) {
    textEditingController.clear();

    Get.find<AddProductController>().addColor(productColorInput);
  }
}