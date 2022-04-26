import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xrda_task_mobile/constants/firebase_cost.dart';
import 'package:xrda_task_mobile/helpers/errors.dart';
import 'package:xrda_task_mobile/helpers/log.dart';
import 'package:xrda_task_mobile/routes/app_pages.dart';

// i love to put all my whole authentication logic in one controller, make that controller pernament
// and use it any where i want the the lifecycle of the app
class AuthController extends GetxController {
  static AuthController authInstance = Get.find();
  late Rx<User?> firebaseUser;
  final resentToken = 0.obs;
  final verficationId = "".obs;

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
    // checks if user is null, if true go to login else go to home page
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

// verify phone number function, sends an otp if verfied throws an exception if not
  void verifyPhoneNumber(String phone, int? resendToken) async {
    try {
      isAuthenticating.value = true;
      await auth.verifyPhoneNumber(
        forceResendingToken: resendToken,
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
          isAuthenticating.value = false;
          Get.toNamed(Routes.otp, arguments: phone);
          // Create a PhoneAuthCredential with the code
          resentToken.value = resendToken ?? 0;
          verficationId.value = verificationId;
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

// just incase the code(otp) is not deliverd properly
  void resendCode(String phone) {
    verifyPhoneNumber(phone, resentToken.value);
  }

// attempts to sign the user
  void signInWithPhone(String smsCode) async {
    try {
      isAuthenticating.value = true;
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verficationId.value, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      isAuthenticating.value = false;
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

// sign the user out
  void signOut() {
    try {
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

// we send an email link to the user and use deep linking to lunch the devices
  void sendEmailLink(String emailAuth) async {
    var acs = ActionCodeSettings(
        // URL you want to redirect back to. The domain (www.example.com) for this
        // URL must be whitelisted in the Firebase Console.
        url: 'https://xrdataskmobiles.page.link/',
        // This must be true
        handleCodeInApp: true,
        iOSBundleId: 'com.example.xrdaTaskMobile',
        androidPackageName: 'com.example.xrda_task_mobile',
        // installIfNotAvailable
        // androidInstallApp: true,

        // dynamicLinkDomain: "xrdataskmobiles.page.link",
        // minimumVersion
        androidMinimumVersion: '1');
    try {
      isAuthenticating.value = true;

      await auth.sendSignInLinkToEmail(
          email: emailAuth, actionCodeSettings: acs);

      isAuthenticating.value = false;
      Get.snackbar("Sent", "Email sent successfully, check your email");
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

// caled when link have been handled and signin  is happening
  void signInwitheEmailLink(Uri? link, userEmail) async {
    if (link != null) {
      try {
        await auth.signInWithEmailLink(
          email: userEmail,
          emailLink: link.toString(),
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
    } else {
      Get.snackbar("Null", "Invalid link or link is empty");
    }
  }
}

// its over for auth ctrl, i will have to speed up the other controllers because we are
// just exaustiong this auth controller
