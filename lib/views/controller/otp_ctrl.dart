import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xrda_task_mobile/constants/icon_assets.dart';
import 'package:xrda_task_mobile/routes/app_pages.dart';
import 'package:xrda_task_mobile/views/controller/auth_controller.dart';
import 'package:xrda_task_mobile/views/screens/widgets/svgs.dart';

class OtpCtrl extends GetxController {
  var label = "".obs;
  final authCtrl = AuthController.authInstance;

  void sigInWithPhone(String phone, String smsCode) {
    if (GetUtils.isNumericOnly(smsCode)) {
      authCtrl.signInwithPhone(phone, smsCode);
    } else {
      Get.snackbar("Not valid", "This sms code is valid");
    }
  }
}
