import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:get/get.dart';
import 'package:xrda_task_mobile/constants/icon_assets.dart';
import 'package:xrda_task_mobile/helpers/log.dart';
import 'package:xrda_task_mobile/routes/app_pages.dart';
import 'package:xrda_task_mobile/views/controller/auth_controller.dart';
import 'package:xrda_task_mobile/views/screens/widgets/svgs.dart';

class OtpCtrl extends GetxController {
  var isSendCode = false.obs;
  late CountdownController countdownController;
  var isRunning = false.obs;
  final authCtrl = AuthController.authInstance;

  @override
  void onInit() {
    // the count down time ctrl
    countdownController = CountdownController(
        duration: const Duration(seconds: 30),
        onEnd: () {
          isSendCode.value = true;
          print('onEnd');
        });
    super.onInit();
  }

  @override
  void onReady() {
    if (!countdownController.isRunning) {
      countdownController.start();

      isRunning.value = true;
    } else {
      countdownController.stop();

      isRunning.value = false;
    }

    super.onReady();
  }

// validation before signing in with phone
  void sigInWithPhone(String smsCode) {
    if (GetUtils.isNumericOnly(smsCode)) {
      authCtrl.signInWithPhone(smsCode);
    } else {
      Get.snackbar("Not valid", "This sms code is valid");
    }
  }

  void validateOtpAndSignIn(
      {required String otp,
      required EmailAuth emailAuth,
      required String email,
      required Uri link}) {
    // check if the otp sent to the email is valid
    var isValid = emailAuth.validateOtp(recipientMail: email, userOtp: otp);
    if (isValid) {
      Get.snackbar("Valid", "Otp validated, Signing in...");
      authCtrl.signInwitheEmailLink(link, email);
    } else {
      Get.snackbar("Not Valid", "Otp entered is not valid");
    }
  }

  // void  resendToken(){
  //    if (isSendCode.value) {
  //               Log.d("otp_screen", "send code");
  //               authCtrl.resendToken(phone, smsCode)
  //               isSendCode.value = false;
  //             }
  // }
}
