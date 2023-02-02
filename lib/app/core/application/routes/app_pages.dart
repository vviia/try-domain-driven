import 'package:trying_to_not_crying/app/features/auth/domain/repository/auth_repo.dart';
import 'package:trying_to_not_crying/app/features/auth/presentation/login_view.dart';
import 'package:trying_to_not_crying/app/features/auth/presentation/register_view.dart';
import 'package:get/get.dart';

import '../../../features/auth/presentation/profile_view.dart';
import '../../../features/home/presentation/home_view.dart';
import '../../../features/product/presentation/add_product/add_product_view.dart';
import '../../../features/product/presentation/all_products/all_products_view.dart';
import '../../../features/product/presentation/product_details/product_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages(this.repo);

  final AuthRepo repo;

  String get initialRoute =>
      repo.getSavedToken() == null ? Routes.LOGIN : Routes.HOME;

  final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => AddProductView(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => ProductDetailsView(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: _Paths.ALL_PRODUCTS,
      page: () => const AllProductsView(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
    ),
  ];
}