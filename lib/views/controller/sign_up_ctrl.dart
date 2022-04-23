import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xrda_task_mobile/constants/icon_assets.dart';
import 'package:xrda_task_mobile/views/screens/widgets/svgs.dart';

class SignUpCtrl extends GetxController {
  var label = "".obs;
  final isPrefix = true.obs;
  final TextEditingController textCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

  void continues() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      Get.snackbar("Successful", "Good work ${textCtrl.text}");
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
    } else {
      Get.snackbar("Not valid", "This is not valid");
    }
  }
}
