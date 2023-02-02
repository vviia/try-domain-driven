import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VariationCard extends StatelessWidget {
  const VariationCard(
      {Key? key,
        required this.onTap,
        required this.text,
        required this.isSelected})
      : super(key: key);
  final String text;

  // on Tap
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // border
          border: Border.all(
            color: Get.theme.primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(text,textAlign: TextAlign.center,)),
        ),
      ),
    );
  }
}