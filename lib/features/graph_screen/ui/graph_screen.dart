import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/networking/order_model.dart';
import '../../../core/theming/font_weight_helper.dart';
import 'components/empty_graph_state.dart';
import 'components/graph_body.dart';

class GraphScreen extends StatelessWidget {
  final List<Order> orders;

  const GraphScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> monthlyOrders = {};
    for (var order in orders) {
      final month =
          "${order.registered.year}-${order.registered.month.toString().padLeft(2, '0')}";
      monthlyOrders[month] = (monthlyOrders[month] ?? 0) + 1;
    }

    final sortedKeys = monthlyOrders.keys.toList()..sort();
    final data = sortedKeys.map((key) => monthlyOrders[key]!).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders Graph',
          style: TextStyle(
            fontWeight: FontWeightHelper.medium,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: data.isNotEmpty
          ? GraphBody(data: data, sortedKeys: sortedKeys)
          : const EmptyGraphState(),
    );
  }
}

