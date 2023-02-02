import 'package:trying_to_not_crying/app/core/infrastructure/device/device_file_picker.dart';
import 'package:trying_to_not_crying/app/core/infrastructure/http/dio.dart';
import 'package:trying_to_not_crying/app/features/auth/application/login/login_controller.dart';
import 'package:trying_to_not_crying/app/features/auth/application/profile/profile_controller.dart';
import 'package:trying_to_not_crying/app/features/auth/application/register/register_controller.dart';
import 'package:trying_to_not_crying/app/features/auth/application/register/register_state.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/repository/auth_repo.dart';
import 'package:trying_to_not_crying/app/features/auth/infrastructure/data_sources/auth_local_data_source.dart';
import 'package:trying_to_not_crying/app/features/auth/infrastructure/data_sources/auth_remote_data_source.dart';
import 'package:trying_to_not_crying/app/features/auth/infrastructure/repositories/auth_repo_impl.dart';
import 'package:trying_to_not_crying/app/features/home/application/home_controller.dart';
import 'package:trying_to_not_crying/app/features/product/application/product_details/product_details_controller.dart';
import 'package:trying_to_not_crying/app/features/product/application/product_details/product_details_state.dart';
import 'package:trying_to_not_crying/app/features/product/domain/repository/product_repo.dart';
import 'package:trying_to_not_crying/app/features/product/infrastructure/mappers/add_product_mapper.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_repo.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_controller.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_color/add_color_state.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_controller.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_product/add_product_state.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_size/add_size_controller.dart';
import 'package:trying_to_not_crying/app/features/product/application/add_product/add_size/add_size_state.dart';
import 'package:trying_to_not_crying/app/features/product/application/all_products/all_product_state.dart';
import 'package:trying_to_not_crying/app/features/product/application/all_products/all_products_controller.dart';
import 'package:trying_to_not_crying/app/features/product/infrastructure/repos/product_repo_impl.dart';
import 'package:trying_to_not_crying/app/core/application/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce_crud_operation/app/features/auth/application/profile/profile_state.dart';
import 'package:get/get.dart';
import 'package:ecommerce_crud_operation/app/features/auth/application/login/login_state.dart';
import 'package:ecommerce_crud_operation/app/features/auth/domain/repository/auth_repo.dart';
import 'package:get/get.dart';

class Injection extends Bindings {
  @override
  Future<void> dependencies() async {
    await GetStorage.init();
    final getStorage = Get.put(GetStorage(), permanent: true);
    final authLocalDataSource =
    Get.put(AuthLocalDataSourceImpl(getStorage), permanent: true);

    final token = authLocalDataSource.getToken();

    final configuredDio = Get.put(ConfiguredDio(token));
    final authRemoteDataSource = Get.put<AuthRemoteDataSource>(
        AuthRemoteDataSourceImpl(configuredDio.dio),
        permanent: true);

    final authRepo = Get.put<AuthRepo>(
        AuthRepoImpl(authRemoteDataSource, authLocalDataSource),
        permanent: true);

    final appPages = Get.put(AppPages(authRepo), permanent: true);

    Get.lazyPut<ProductRepo>(() => ProductRepoImpl(configuredDio.dio),
        fenix: true);

    Get.lazyPut(() => DeviceFilePicker(ImagePicker()), fenix: true);

    Get.lazyPut<AllProductsController>(
            () => AllProductsController(
            AllProductState.initial(), Get.find<ProductRepo>()),
        fenix: true);
    Get.lazyPut<LoginController>(
            () => LoginController(Get.find<AuthRepo>(), LoginState.initial()),
        fenix: true);

    Get.lazyPut(
            () => AddProductRepo(
            Get.find<ProductRepo>(), Get.find(), ProductMapper()),
        fenix: true);

    Get.lazyPut(() => AddColorController(AddColorState.initial(), Get.find()),
        fenix: true);
    Get.lazyPut(
            () => AddSizeController(
          AddSizeState.initial(),
        ),
        fenix: true);
    Get.lazyPut(
            () => AddProductController(
          ProductState.initial(),
          Get.find(),
        ),
        fenix: true);
    Get.lazyPut<HomeController>(
            () => HomeController(),
        fenix: true
    );

    Get.lazyPut<ProfileController>(
            () => ProfileController(
          ProfileState(ProfileDataLoadingInProgress()),
          Get.find(),
        ),
        fenix: true);
    Get.lazyPut<RegisterController>(
          () => RegisterController(Get.find<AuthRepo>(), RegisterState.initial()),fenix: true,
    );
    Get.lazyPut<ProductDetailsController>(
            () =>
            ProductDetailsController(ProductDetailsState.initial(Get.arguments)),
        fenix: true
    );


  }
}