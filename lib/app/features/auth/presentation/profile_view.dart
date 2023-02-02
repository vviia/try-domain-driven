import 'package:trying_to_not_crying/app/core/application/routes/app_pages.dart';
import 'package:trying_to_not_crying/app/core/domain/failures/failure.dart';
import 'package:trying_to_not_crying/app/features/auth/application/profile/profile_state.dart';
import 'package:trying_to_not_crying/app/features/auth/application/profile/profile_view_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../application/profile/profile_controller.dart';

class ProfileView extends GetView<ProfileController>
    implements ProfileViewContract {
  const ProfileView({Key? key}) : super(key: key);
  @override
  StatelessElement createElement() {
    controller.view = this;
    return super.createElement();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(builder: (logic) {
        final state = controller.state;
        final stateData = state.dataState;
        if (stateData is ProfileDataLoadingInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (stateData is ProfileDataLoadingSuccess) {
          final user = stateData.user.user;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Profile Info',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                    Text('Name: ${user.name.getOrCrash()}'),
                    Text('Email: ${user.email.getOrCrash()}'),
                    Text('Password: ${user.password.getOrCrash()}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        controller.onTapLogoutButton();
                      },
                      child: const Text('Logout'),
                    ),
                  ]),
            ),
          );
        }
        return Center(
          child: Text('Something went wrong'),
        );
      }),
    );
  }

  @override
  void onLogoutFailed(Failure failure) {
    Get.snackbar('Logout Failed', 'Something went wrong');
  }

  @override
  void onLogoutSuccess() {
    Get.offAllNamed(Routes.LOGIN);
  }
}