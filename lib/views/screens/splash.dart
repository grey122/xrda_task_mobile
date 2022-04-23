import 'package:flutter/material.dart';
import 'package:xrda_task_mobile/constants/color_selection.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: LinearProgressIndicator(
              backgroundColor: ColorsConst.primary.withOpacity(0.1),
              color: ColorsConst.primary),
        ),
      )),
    );
  }
}
