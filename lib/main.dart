// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

import 'package:trying_to_not_crying/app/core/infrastructure/injection/injection.dart';
import 'package:trying_to_not_crying/app/core/presentation/widgets/custom_material_app.dart';
import 'package:trying_to_not_crying/app/core/application/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection().dependencies();
  runApp(CustomMaterialApp(
    appPages: Get.find<AppPages>(),
  ));
}