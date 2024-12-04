import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/networking/order_model.dart';
import '../../../core/theming/font_weight_helper.dart';
import '../data/models/metric_data.dart';
import 'components/metric_card.dart';
import 'components/metrics_header.dart';

class NumericMetricsScreen extends StatelessWidget {
  final List<Order> orders;

  const NumericMetricsScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final totalOrders = orders.length;
    final averagePrice =
        orders.map((e) => e.price).reduce((a, b) => a + b) / totalOrders;
    final returnsCount =
        orders.where((order) => order.status == "RETURNED").length;

    final metrics = [
      MetricData(
        icon: Icons.shopping_bag_rounded,
        color: Colors.blue,
        label: 'Total Orders',
        value: totalOrders.toString(),
      ),
      MetricData(
        icon: Icons.attach_money,
        color: Colors.green,
        label: 'Average Price',
        value: '\$${averagePrice.toStringAsFixed(2)}',
      ),
      MetricData(
        icon: Icons.autorenew,
        color: Colors.red,
        label: 'Returns',
        value: returnsCount.toString(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Metrics Overview',
          style: TextStyle(
            fontWeight: FontWeightHelper.medium,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const MetricsHeader(
                title: 'Key Insights',
                subtitle: 'Get a quick overview of your data metrics',
              ),
              verticalSpace(24),
              ...metrics.map((metric) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: MetricCard(metric: metric),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
