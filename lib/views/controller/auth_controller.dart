import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xrda_task_mobile/constants/firebase_cost.dart';
import 'package:xrda_task_mobile/helpers/errors.dart';
import 'package:xrda_task_mobile/helpers/log.dart';
import 'package:xrda_task_mobile/routes/app_pages.dart';

class AuthController extends GetxController {
  static AuthController authInstance = Get.find();
  late Rx<User?> firebaseUser;

  /// use this virable if you want to add a loading effect during authentication
  var isAuthenticating = false.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      isAuthenticating.value = false;

      Get.offAllNamed(Routes.home, arguments: user);

      // user is logged in

    } else {
      isAuthenticating.value = false;
      // user is null as in user is not available or not logged in
      Get.offAllNamed(Routes.signUp);
    }
  }

  void register(String email, String password, String fullName) async {
    try {
      isAuthenticating.value = true;

      final userInfo = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userInfo.user?.updateDisplayName(fullName);

      Log.d("auth", "userInfo: ${userInfo.user?.displayName}");
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      isAuthenticating.value = false;
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      isAuthenticating.value = false;
      // this is temporary. you can handle different kinds of activities
      //such as dialogue to indicate what's wrong
      Log.d("auth_controller", e.toString());
    }
  }

  void signInwithPhone(String phone, String smsCode) async {
    try {
      isAuthenticating.value = true;
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {
          // only for android
          Get.snackbar("Completed", "Verfication have been completed");
        },
        verificationFailed: (FirebaseAuthException e) {
          Log.d("auth_controller", e.message!);
          isAuthenticating.value = false;
          Errors.authentication(e);
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
          try {
            // Sign the user in (or link) with the credential
            await auth.signInWithCredential(credential);
          } on FirebaseAuthException catch (e) {
            // this is solely for the Firebase Auth Exception
            // for example : password did not match
            // print(e.message);
            isAuthenticating.value = false;

            Errors.authentication(e);

            Log.d("auth_controller", e.code);
          } catch (e) {
            Get.snackbar("Error", e.toString());
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      // print(e.message);
      isAuthenticating.value = false;
      Errors.authentication(e);

      Log.d("auth_controller", e.code);
    } catch (e) {
      isAuthenticating.value = false;
      Log.d("auth_controller", e.toString());
    }
  }

  // TODO: when dynamlic is implemented, work on this code

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
            url: "https://nowahalamobile.page.link/",
            handleCodeInApp: true,
            iOSBundleId: "com.example.noWahalaMobile"),
      );
      // auth.confirmPasswordReset(code: code, newPassword: newPassword)
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      print(e.message);
      print(e.stackTrace);
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Log.d("auth_controller", e.toString());
    }
  }

  void signOut() {
    try {
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
