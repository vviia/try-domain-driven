import 'package:trying_to_not_crying/app/features/auth/presentation/profile_view.dart';
import 'package:trying_to_not_crying/app/features/product/presentation/all_products/all_products_view.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersistentBottomNavigationBar extends StatelessWidget {
  PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      AllProductsView(),
      ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home".tr),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle_outlined),
        title: ("Profile".tr),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,

/*
        activeColorPrimary: an.colorPrimary(context),
        inactiveColorPrimary: an.colorSubTitle(context),
*/
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,

      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: an.colorBox(context),
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: an.colorBox(context),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
      NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }
}

class an {
  //=============== theme Colors App ======
  static colorScaffold(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  static colorTitle(BuildContext context) => Theme.of(context).canvasColor;

  static colorSubTitle(BuildContext context) => Theme.of(context).cardColor;

  static colorBox(BuildContext context) => Theme.of(context).backgroundColor;

  static colorPrimary(BuildContext context) => Theme.of(context).primaryColor;

//============= font Size Responsive ===========
}