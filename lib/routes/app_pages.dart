// ignore: avoid_classes_with_only_static_members

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:xrda_task_mobile/views/binding/sign_up_binding.dart';
import 'package:xrda_task_mobile/views/screens/sign_up.dart';
import 'package:xrda_task_mobile/views/screens/splash.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  //  static const INITIAL = Routes.HOMESCREENLOADING;
  static const initial = "/";

  static final routes = [
    GetPage(
      name: "/",
      binding: SignUpBinding(),
      page: () => const SignUp(),
    ),
    // GetPage(
    //   name: Routes.login,
    //   binding: LoginBinding(),
    //   // binding: PlacesBinding(),
    //   page: () => const LoginScreen(),
    // ),
  ];
}
