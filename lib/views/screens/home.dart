import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xrda_task_mobile/views/controller/auth_controller.dart';
import 'package:xrda_task_mobile/views/screens/widgets/buttons.dart';

// a simple screen that tells the user he have been logged in
// and he can also logout here
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Get.arguments;
    // final String dynamlicLink = Get.arguments;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            // "link $dynamlicLink"
            "welcome ${user.email ?? user.phoneNumber}",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 30, right: 30),
            child: AuthBtn(
              text: "LogOut",
              onPressed: () {
                AuthController.authInstance.signOut();
              },
            ),
          ),
        ],
      )),
    );
  }
}
