import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

/// Simple class that uses the power of getx to display snackbar for errors
class Errors {
  static void authentication(FirebaseAuthException e) {
    if (e.code == "network-request-failed") {
      _snackbarHelper("No Internet: Connect To Wifi");
    } else {
      _snackbarHelper(e.message ?? "Undefined");
    }
  }

  static void functions(dynamic e) {
    _snackbarHelper(e.toString());
  }

  static SnackbarController _snackbarHelper(String message,
      {String tittle = "Error"}) {
    return Get.snackbar(
      tittle,
      message,
      snackPosition: SnackPosition.TOP,
    );
  }
}
