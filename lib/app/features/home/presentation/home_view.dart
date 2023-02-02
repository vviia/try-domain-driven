import 'package:trying_to_not_crying/app/core/presentation/widgets/Persistent_BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../application/home_controller.dart';

enum CurrentPage { lastMessages, addTrip, clientOrders, myTrips, notifications }

class HomeView extends GetView<HomeController> {
  CurrentPage currentPage = CurrentPage.clientOrders;

  HomeView({Key? key}) : super(key: key);
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<void> onTapBottomNavigationIcon(
      CurrentPage currentPage, String route) async {
    if (this.currentPage == currentPage) return;
    this.currentPage = currentPage;

    navigatorKey.currentState!.pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentBottomNavigationBar(),
      /*  body: Navigator(
          initialRoute: Routes.ALL_PRODUCTS,
          onPopPage: (x, y) {
            return true;
          },
          key: navigatorKey,
        )*/
    );
  }
}
/*
 SizedBox(
            height: 65,
            child: BottomAppBar(
                shape: CircularNotchedRectangle(),
                elevation: 1,
                notchMargin: 8,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Row(children: [
                      BottomNavigationBarIcon(
                        onTap: () => onTapBottomNavigationIcon(
                            CurrentPage.lastMessages, Routes.ALL_PRODUCTS),
                        icon: Image.asset(
                          'assets/images/speech.png',
                          color: Colors.white,
                          width: 25,
                          height: 25,
                          // semanticsLabel: 'A red up arrow'
                        ),
                        text: 'رسائل',
                      ),
                      BottomNavigationBarIcon(
                        onTap: () => onTapBottomNavigationIcon(
                            CurrentPage.addTrip, Routes.PROFILE),
                        icon: Icon(
                          Icons.card_travel_sharp,
                          // size: 25,
                          color: Colors.white,
                        ),
                        text: 'اضف رحلة',
                      )
                    ])))),
                    class BottomNavigationBarIcon extends StatelessWidget {
  final Widget icon;

  final VoidCallback onTap;

  final String text;

  const BottomNavigationBarIcon({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            icon,
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(height: 1.2, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

 */