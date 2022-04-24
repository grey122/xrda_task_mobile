import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xrda_task_mobile/constants/color_selection.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:xrda_task_mobile/views/controller/otp_ctrl.dart';

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
    final ctrl = Get.find<OtpCtrl>();
    final String phone = Get.arguments;
    return Scaffold(
      appBar: AppBar(
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
                child: Center(
                  child: PinCodeTextField(
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
                      ctrl.sigInWithPhone(phone, v);
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
                ),
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildItem("countdown", CountdownPage()),
          // buildItem("countdown page", CountdownTimerPage()),
        ],
      ),
    );
  }

  Widget buildItem(String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return page;
        }));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        color: Colors.blue,
        width: double.infinity,
        alignment: Alignment.center,
        height: 100,
        child: Text(
          title,
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}

class CountdownPage extends StatefulWidget {
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  CountdownController countdownController = CountdownController(
      duration: Duration(seconds: 30),
      onEnd: () {
        print('onEnd');
      });
  bool isRunning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Countdown(
            countdownController: countdownController,
            builder: (_, Duration time) {
              return Text(
                'hours: ${time.inHours} minutes: ${time.inMinutes % 60} seconds: ${time.inSeconds % 60}',
                style: TextStyle(fontSize: 20),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isRunning ? Icons.stop : Icons.play_arrow),
        onPressed: () {
          if (!countdownController.isRunning) {
            countdownController.start();
            setState(() {
              isRunning = true;
            });
          } else {
            countdownController.stop();
            setState(() {
              isRunning = false;
            });
          }
        },
      ),
    );
  }
}
