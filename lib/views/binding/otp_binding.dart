import 'package:get/get.dart';
import 'package:xrda_task_mobile/views/controller/otp_ctrl.dart';
import 'package:xrda_task_mobile/views/controller/sign_up_ctrl.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpCtrl>(() => OtpCtrl());
  }
}
