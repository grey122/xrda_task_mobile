import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xrda_task_mobile/constants/firebase_cost.dart';
import 'package:xrda_task_mobile/routes/app_pages.dart';
import 'package:xrda_task_mobile/views/controller/auth_controller.dart';

// get material app is being used instead of material app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await firebaseInitialization;

  firebaseInitialization.then((value) {
    // we are going to inject the auth controller over here!
    // for convinence reason i am injecting the auth controller when we inisialize firebase base
    // and making it pernament in memory, meaning getx smart magement cant delete it
    Get.put(AuthController(), permanent: true);
  });

  runApp(
    GetMaterialApp(
      //  routerDelegate: ,
      initialRoute: AppPages.initial,
      title: 'xrda',
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
