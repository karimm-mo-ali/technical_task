import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/networking/order_model.dart';

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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: data.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: data.reduce((a, b) => a > b ? a : b).toDouble() + 2,
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < sortedKeys.length) {
                            return Transform.rotate(
                              angle: -0.5, // Rotate labels for readability
                              child: Text(
                                sortedKeys[value.toInt()],
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 40,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                        reservedSize: 32,
                      ),
                    ),
                  ),
                  barGroups: data
                      .asMap()
                      .entries
                      .map(
                        (entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              fromY: 0,
                              toY: entry.value.toDouble(),
                              color: Colors.blueAccent,
                              width: 16,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(6),
                              ),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey.shade200,
                                fromY: 0,
                                toY: data
                                    .reduce((a, b) => a > b ? a : b)
                                    .toDouble(),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 2,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipPadding: const EdgeInsets.all(6),
                      tooltipRoundedRadius: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${sortedKeys[group.x.toInt()]}\n',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Orders: ${rod.toY.toInt()}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
          : const Center(
              child: Text(
                'No orders data available to display',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
    );
  }
}
