import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xrda_task_mobile/constants/color_selection.dart';
import 'package:xrda_task_mobile/helpers/utils.dart';

typedef ButtonCallback = void Function();

class AuthBtn extends StatelessWidget {
  const AuthBtn({
    required this.text,
    Key? key,
    required this.onPressed,
    this.borderRadius,
  }) : super(key: key);
  final ButtonCallback? onPressed;
  final String text;

  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        // minimumSize: Size.zero,
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        maximumSize: Size(width(context), 51),

        minimumSize: Size(width(context), 51),
        backgroundColor: ColorsConst.primary,

        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8)),
        textStyle: Theme.of(context).textTheme.button,
        // onPrimary: Theme.of(context).colorScheme.onSecondary,
        // elevation: 2.0,
        // minimumSize: Size(width(context), height(context) * 0.08),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          letterSpacing: 0.3,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
