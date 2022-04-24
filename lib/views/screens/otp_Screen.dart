import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xrda_task_mobile/constants/color_selection.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              PinCodeTextField(
                length: 6,
                obscureText: true,

                animationType: AnimationType.fade,
                cursorColor: ColorsConst.primary,
                enablePinAutofill: true,
                // validator: ,
                validator: (value) {
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
                errorAnimationController: errorController,
                controller: textEditingController,
                onCompleted: (v) {
                  print("Completed");
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
              // Padding(
              //   padding: const EdgeInsets.only(top: 37),
              //   child: AuthBtn(
              //     isComplete: false,
              //     onPressed: () {
              //       Get.toNamed(Routes.passwordRecoveryNewPassword);
              //     },
              //     text: "Send code",
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
