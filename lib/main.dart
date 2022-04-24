import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xrda_task_mobile/constants/firebase_cost.dart';
import 'package:xrda_task_mobile/routes/app_pages.dart';
import 'package:xrda_task_mobile/views/controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  firebaseInitialization.then((value) {
    // we are going to inject the auth controller over here!
    Get.put(AuthController(), permanent: true);
  });

  runApp(
    GetMaterialApp(
      //  routerDelegate: ,
      initialRoute: AppPages.initial,
      title: 'No Wahala',
      theme: ThemeData(
        // accentColor: colorSchemeData.secondary,
        scaffoldBackgroundColor: Colors.white,
      ),

      // accentTextTheme: textThemeData,

      defaultTransition: Transition.cupertino,
      getPages: AppPages.routes,
    ),
  );
}
