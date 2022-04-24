import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xrda_task_mobile/views/screens/widgets/buttons.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Get.arguments;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "welcome ${user.email ?? user.phoneNumber}",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 30, right: 30),
            child: AuthBtn(text: "LogOut", onPressed: () {}),
          ),
        ],
      )),
    );
  }
}
