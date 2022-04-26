// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xrda_task_mobile/constants/color_selection.dart';
import 'package:xrda_task_mobile/constants/firebase_cost.dart';
import 'package:xrda_task_mobile/constants/icon_assets.dart';
import 'package:xrda_task_mobile/routes/app_pages.dart';
import 'package:xrda_task_mobile/views/controller/sign_up_ctrl.dart';
import 'package:xrda_task_mobile/views/screens/widgets/buttons.dart';
import 'package:xrda_task_mobile/views/screens/widgets/input_text.dart';
import 'package:xrda_task_mobile/views/screens/widgets/svgs.dart';

// this is the signup screen, it kinda knows if you are signing in with a phone or email
// simple if else, nothing complicated hehehe!
// and it also handles deep linking here to
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with WidgetsBindingObserver {
  final TextEditingController textCtrl = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    handleDeepLink();
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  final emailAuth = EmailAuth(sessionName: "Test session");
  void sendOtp() async {
    var res = await emailAuth.sendOtp(recipientMail: textCtrl.text);
    if (res) {
      Get.snackbar("Otp Sent", "otp sent properly");
    } else {
      Get.snackbar("Error", "Something happend");
    }
  }

  void handleDeepLink() async {
    try {
      // we get the link if any, and send an otp and also navigate to the otp screen with some argument
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri? deepLink = dynamicLink?.link;
        if (deepLink != null) {
          // send an otp code here
          sendOtp();
          Get.toNamed(Routes.otp, arguments: {
            "email": textCtrl.text,
            "link": deepLink,
            "emailAuth": emailAuth
          });
        }
      }, onError: (e) async {
        Get.snackbar("Error", e.message ?? "Unknown");
      });

      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        print(deepLink.userInfo);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // mostly ui stuff, the intresting stuffs are in the controller class,
    //this is to keep the code base neat, and also room to scale if need be
    final ctrl = Get.find<SignUpCtrl>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Connect your wallet",
          style: GoogleFonts.poppins(
            fontSize: 28,
            letterSpacing: 0.3,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: ctrl.formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 24, right: 24),
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: Text(
                        "We’ll send you a confirmation code",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          // letterSpacing: 0.3,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Obx(
                    () => ctrl.authCtrl.isAuthenticating.value
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
                            child: LinearProgressIndicator(
                                backgroundColor:
                                    ColorsConst.primary.withOpacity(0.1),
                                color: ColorsConst.primary),
                          )
                        : const SizedBox(),
                  ),
                ),
                Container(
                  height: 63,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: ColorsConst.inputTextBorderColor, width: 1),
                  ),
                  child: Obx(
                    () => InputTextNoBorder(
                      // autovalidateMode: AutovalidateMode.always,
                      onChanged: ctrl.changedValue,
                      validator: ctrl.textValidator,
                      controller: textCtrl,
                      hintText: "",
                      prefix: ctrl.isPrefix.value
                          ? IconButton(
                              onPressed: () {},
                              icon: const SvgIcon(IconsAssets.uk))
                          : null,
                      label: ctrl.label.value == ""
                          ? "Phone number or Email"
                          : ctrl.label.value,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: AuthBtn(
                      text: "Continue",
                      onPressed: () {
                        ctrl.continues(textCtrl.text);
                        // sendOtp();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 21),
                  child: RichText(
                    text: TextSpan(
                      text: 'By signing up I agree to Zëdfi’s',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        letterSpacing: 0.3,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      children: [
                        TextSpan(
                          text: "  Privacy Policy",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " and",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        TextSpan(
                          text: " Terms of Use",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              " and allow Zedfi to use your information for future",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        TextSpan(
                          text: " Marketing purposes.",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
