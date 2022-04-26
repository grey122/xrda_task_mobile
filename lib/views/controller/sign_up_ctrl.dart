import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xrda_task_mobile/constants/icon_assets.dart';
import 'package:xrda_task_mobile/routes/app_pages.dart';
import 'package:xrda_task_mobile/views/controller/auth_controller.dart';
import 'package:xrda_task_mobile/views/screens/widgets/svgs.dart';

class SignUpCtrl extends GetxController {
  var label = "".obs;
  final isPrefix = true.obs;

  final formKey = GlobalKey<FormState>();
  final authCtrl = AuthController.authInstance;
// nothing to fancy here, just if else statments
  void changedValue(String? value) {
    if (value == null || value.isEmpty) {
      isPrefix.value = true;
      label.value = "Phone number or Email";
    } else if (value.startsWith("+")) {
      isPrefix.value = true;
      label.value = "phone";
    } else {
      isPrefix.value = false;
      label.value = "Phone number or Email";
    }
  }

  String? textValidator(String? value) {
    if (value!.startsWith("+")) {
      if (!GetUtils.isPhoneNumber(value)) {
        return "please Enter valid phone number";
      } else {
        return null;
      }
    } else {
      if (!GetUtils.isEmail(value)) {
        return "please Enter valid Email";
      } else {
        return null;
      }
    }
  }

  Widget? iconValue() {
    if (label.value == "") {
      return IconButton(onPressed: () {}, icon: const SvgIcon(IconsAssets.uk));
    }
    if (label.value.startsWith("+")) {
      return IconButton(onPressed: () {}, icon: const SvgIcon(IconsAssets.uk));
    } else {
      return null;
    }
  }

  void continues(String text) {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();

      if (text.startsWith("+")) {
        authCtrl.verifyPhoneNumber(text, null);
      } else {
        authCtrl.sendEmailLink(text);
      }
    }

    // isLoginng.value = true;
    // authCtrl.login(
    //   emailController.text.trim(),
    //   passwordController.text.trim(),
    // );
    // Get.snackbar(
    //   "Login data",
    //   "email: " +
    //       emailController.text.trim() +
    //       "password: " +
    //       passwordController.text.trim(),
    // );
    else {
      Get.snackbar("Not valid", "This is not valid");
    }
  }
}

// lets start with phone number
// my wifi got not on
// i am back
// lets start with phone 
// this is the test phone number , google is verify i am not a robot 
// now lets test the email account 

// the deep linking is starting, 
// we just sent an otp to the user email
// my emulator is a little bit slow today, but it got the work done 
