import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/font_weight_helper.dart';

class EmptyGraphState extends StatelessWidget {
  const EmptyGraphState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No orders data available to display',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeightHelper.medium,
          color: Colors.grey,
        ),
      ),
    );
  }
}
