import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/font_weight_helper.dart';
import '../../data/models/metric_data.dart';

class MetricCard extends StatelessWidget {
  final MetricData metric;

  const MetricCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 4,
      shadowColor: metric.color.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: metric.color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(metric.icon, color: metric.color, size: 28),
            ),
            verticalSpace(12),
            Text(
              metric.label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.medium,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(8),
            Text(
              metric.value,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeightHelper.bold,
                color: metric.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
