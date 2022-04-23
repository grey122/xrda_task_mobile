import 'package:get/get.dart';
import 'package:xrda_task_mobile/views/controller/sign_up_ctrl.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpCtrl>(() => SignUpCtrl());
  }
}
