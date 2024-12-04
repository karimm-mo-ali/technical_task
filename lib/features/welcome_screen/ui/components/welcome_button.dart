import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';

class WelcomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Icon icon;
  final Color color;
  final Color? labelColor;

  const WelcomeButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.color,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          horizontalSpace(8),
          Text(label, style: TextStyle(color: labelColor ?? Colors.white)),
        ],
      ),
    );
  }
}
