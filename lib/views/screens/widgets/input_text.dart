import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xrda_task_mobile/constants/icon_assets.dart';
import 'package:xrda_task_mobile/views/screens/widgets/svgs.dart';

class InputTextNoBorder extends StatelessWidget {
  final String hintText;
  final String? label;
  final TextInputAction textInputAction;

  // final TextEditingController controller;
  //TODO: learn how to use voidcallback here
  final dynamic onSave;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final void Function(String)? onChanged;
  const InputTextNoBorder({
    Key? key,
    required this.hintText,
    required this.textInputAction,
    this.onSave,
    this.validator,
    this.hintStyle,
    this.prefix,
    this.label,
    this.controller,
    this.autovalidateMode,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        // controller: controller,
        key: key,

        onChanged: onChanged,
        onSaved: onSave,
        validator: validator,
        controller: controller,
        autovalidateMode: autovalidateMode,

        textInputAction: textInputAction,

        cursorColor: Colors.black,

        decoration: InputDecoration(
          prefixIcon: prefix,

          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
          // hintText: hintText,
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            fontSize: 12,
            // letterSpacing: 0.3,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.6),
          ),
          alignLabelWithHint: false,
          hintStyle: hintStyle ??
              GoogleFonts.poppins(
                fontSize: 18,
                // letterSpacing: 0.3,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.6),
              ),
        ),
      ),
    );
  }
}
