import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/networking/order_model.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/font_weight_helper.dart';
import 'components/welcome_button.dart';
import 'components/welcome_header.dart';

class WelcomeScreen extends StatelessWidget {
  final List<Order> orders;

  const WelcomeScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FlapKap Challenge',
          style: TextStyle(
            fontWeight: FontWeightHelper.medium,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const WelcomeHeader(),
            verticalSpace(40),
            WelcomeButton(
              onPressed: () => context.pushNamed(
                Routes.numericMetricsScreen,
                arguments: {"orders": orders},
              ),
              label: 'View Numeric Metrics',
              icon: const Icon(Icons.numbers_rounded, color: Colors.white),
              color: Colors.blueAccent,
            ),
            verticalSpace(16),
            WelcomeButton(
              onPressed: () => context.pushNamed(
                Routes.graphScreen,
                arguments: {"orders": orders},
              ),
              label: 'View Graph',
              icon: const Icon(Icons.bar_chart_rounded, color: Colors.black),
              color: Colors.greenAccent,
              labelColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
