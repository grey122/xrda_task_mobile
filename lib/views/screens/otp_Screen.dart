import 'dart:io';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xrda_task_mobile/constants/color_selection.dart';

import 'package:xrda_task_mobile/helpers/log.dart';
import 'package:xrda_task_mobile/views/controller/otp_ctrl.dart';

// otp screen, i am using a pretty cool package here to handle the otp
class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final ctrl = Get.find<OtpCtrl>();
    // arguments/ parameter may vary depending on what user authentication is
    String phone = "";

    Map<String, dynamic> email = {};
    if (Get.arguments is String) {
      phone = Get.arguments;
    } else {
      email = Get.arguments;
    }

// again just ui stuff
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Platform.isIOS
                ? const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "We have Sent You a code",
          style: GoogleFonts.poppins(
            fontSize: 25,
            // letterSpacing: 0.3,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter the confirmation code below ",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  // letterSpacing: 0.3,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              Obx(
                () => ctrl.authCtrl.isAuthenticating.value
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(60, 60, 60, 0),
                        child: LinearProgressIndicator(
                            backgroundColor:
                                ColorsConst.primary.withOpacity(0.1),
                            color: ColorsConst.primary),
                      )
                    : const SizedBox(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PinCodeTextField(
                      key: const Key("pincodekey"),
                      length: 6,
                      obscureText: true,

                      animationType: AnimationType.fade,
                      cursorColor: ColorsConst.primary,
                      enablePinAutofill: true,
                      // validator: ,
                      validator: (value) {
                        // validating the otp here making sure there are only numebrs
                        if (!GetUtils.isNumericOnly(value!)) {
                          return "Value can Only be numbers";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 69,
                        inactiveFillColor: Colors.white,
                        activeFillColor: Colors.white,
                        errorBorderColor: Colors.redAccent,

                        // activeColor: ColorsConst.blackThree,
                        inactiveColor: ColorsConst.blackFive,
                        activeColor: ColorsConst.blackThree,
                        fieldOuterPadding: const EdgeInsets.only(right: 9),
                        fieldWidth: 47,
                        selectedFillColor: ColorsConst.blackSix,
                        selectedColor: ColorsConst.blackThree,

                        // activeFillColor: ColorsConst.blackSix,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      // backgroundColor: Colors.blue.shade50,
                      enableActiveFill: true,

                      controller: textEditingController,
                      onCompleted: (v) {
                        // validate otp
                        if (phone != "") {
                          ctrl.sigInWithPhone(v);
                        } else {
                          final EmailAuth emailAuth = email["emailAuth"];
                          final String userEmail = email["email"];
                          final Uri link = email["link"];
                          ctrl.validateOtpAndSignIn(
                              otp: v,
                              emailAuth: emailAuth,
                              email: userEmail,
                              link: link);
                        }

                        // textEditingController.clear();
                        Log.d("otp_screen", "completed");
                      },
                      onChanged: (value) {
                        print(value);
                        // setState(() {
                        //   currentText = value;
                        // });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      appContext: context,
                    ),
                    // just a countdown widget timer, nothing fancy, i had to use a package for this,
                    // but its really not that hard to implemnt
                    CountdownPage(onTap: () async {
                      if (ctrl.isSendCode.value) {
                        if (phone != "") {
                          Log.d("otp_screen", "send code");
                          ctrl.authCtrl.resendCode(phone);
                        } else {
                          final EmailAuth emailAuth = email["emailAuth"];
                          final String userEmail = email["email"];

                          var res =
                              await emailAuth.sendOtp(recipientMail: userEmail);
                          if (res) {
                            Get.snackbar("Otp Sent", "otp sent properly");
                          } else {
                            Get.snackbar("Error", "Something happend");
                          }
                        }
                        textEditingController.clear();
                        ctrl.isSendCode.value = false;
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountdownPage extends StatelessWidget {
  const CountdownPage({Key? key, required this.onTap}) : super(key: key);
  // final String phone;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<OtpCtrl>();
    return Countdown(
        countdownController: ctrl.countdownController,
        builder: (_, Duration time) {
          return InkWell(
            onTap: onTap,
            child: RichText(
              text: TextSpan(
                text: 'Didn’t recieve a code?',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                ),
                children: [
                  ctrl.isSendCode.value
                      ? TextSpan(
                          text: "  Send code > ",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      : TextSpan(
                          text: "  Wait for ${time.inSeconds % 60} sec",
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
          );
        });
  }
}
