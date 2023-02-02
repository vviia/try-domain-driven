import 'package:trying_to_not_crying/app/core/application/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({Key? key, required this.appPages}) : super(key: key);
  final AppPages appPages;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return SafeArea(
          child: child!,
        );
      },
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        colorScheme: ColorScheme.light(
          secondary: Color(0xFF151026),
        ),
        appBarTheme: AppBarTheme(
          color: const Color(0xFF151026),
        ),
        backgroundColor: Color(0xFF151026),
        primaryColor: Color(0xFF151026),
        inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true),
        primarySwatch: Colors.blue,
      ),
      title: "Application",
      initialRoute: appPages.initialRoute,
      getPages: appPages.routes,
    );
  }
}