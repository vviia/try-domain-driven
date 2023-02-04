import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:trying_to_not_crying/app/core/domain/failures/failure.dart';
import 'package:trying_to_not_crying/app/core/infrastructure/device/device_file_picker.dart';
import 'package:trying_to_not_crying/app/features/product/infrastructure/mappers/add_product_mapper.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_state.dart';
import 'package:trying_to_not_crying/app/features/product/domain/entities/product_entity.dart';
import 'package:trying_to_not_crying/app/features/product/domain/repository/product_repo.dart';
import 'package:get/get.dart';

class AddProductRepo extends GetxService {
  final DeviceFilePicker filePicker;
  final ProductRepo productRepo;
  final ProductMapper mapper;

  AddProductRepo(this.productRepo, this.filePicker, this.mapper);

  Future<List<File>> pickMultiImage() {
    return filePicker.pickMultiImage();
  }

  Future<Either<Failure, Unit>> add(ProductState state) async {
    return productRepo.add(mapper.productInputFromState(state));
  }
}