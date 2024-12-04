import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/font_weight_helper.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.bar_chart_rounded,
          size: 80,
          color: Colors.blueAccent,
        ),
        verticalSpace(8),
        Text(
          "Welcome to FlapKap Analytics",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeightHelper.bold,
          ),
          textAlign: TextAlign.center,
        ),
        verticalSpace(4),
        Text(
          "Analyze and visualize your orders data with ease.",
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
