import 'package:trying_to_not_crying/app/features/auth/application/profile/profile_events.dart';
import 'package:trying_to_not_crying/app/features/auth/application/profile/profile_state.dart';
import 'package:trying_to_not_crying/app/features/auth/application/profile/profile_view_contract.dart';
import 'package:trying_to_not_crying/app/features/auth/domain/repository/auth_repo.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController implements ProfileEvents {
  ProfileState state;
  final AuthRepo repo;
  late final ProfileViewContract view;

  ProfileController(this.state, this.repo);

  Future<void> getMyProfile() async {
    state = state.copyWith(dataState: ProfileDataLoadingInProgress());
    update();
    final profile = await repo.getMyProfile();
    state = state.copyWith(
        dataState: profile.fold((l) => ProfileDataFailure(),
                (r) => ProfileDataLoadingSuccess(user: r)));
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getMyProfile();
  }

  @override
  Future<void> onTapLogoutButton() async {
    final result = await repo.logout();
    result.fold(view.onLogoutFailed, (r) => view.onLogoutSuccess());
  }
}