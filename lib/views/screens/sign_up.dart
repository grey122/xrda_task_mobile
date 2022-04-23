import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xrda_task_mobile/constants/color_selection.dart';
import 'package:xrda_task_mobile/constants/icon_assets.dart';
import 'package:xrda_task_mobile/views/controller/sign_up_ctrl.dart';
import 'package:xrda_task_mobile/views/screens/widgets/buttons.dart';
import 'package:xrda_task_mobile/views/screens/widgets/input_text.dart';
import 'package:xrda_task_mobile/views/screens/widgets/svgs.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      controller: ctrl.textCtrl,
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
                        ctrl.continues();
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
