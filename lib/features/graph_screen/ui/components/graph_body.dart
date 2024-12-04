import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/font_weight_helper.dart';

class GraphBody extends StatelessWidget {
  final List<int> data;
  final List<String> sortedKeys;

  const GraphBody({super.key, required this.data, required this.sortedKeys});

  @override
  Widget build(BuildContext context) {
    final maxY = data.reduce((a, b) => a > b ? a : b).toDouble() + 2;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          titlesData: _buildTitlesData(sortedKeys),
          barGroups: _buildBarGroups(data),
          gridData: _buildGridData(),
          borderData: _buildBorderData(),
          barTouchData: _buildBarTouchData(sortedKeys),
        ),
      ),
    );
  }
}

FlTitlesData _buildTitlesData(List<String> sortedKeys) {
  return FlTitlesData(
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
            return Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Transform.rotate(
                angle: -0.5, // Rotate labels for readability
                child: Text(
                  sortedKeys[value.toInt()],
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
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
  );
}

List<BarChartGroupData> _buildBarGroups(List<int> data) {
  return data
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
              width: 14.w,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(6.r),
              ),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                color: Colors.grey.shade200,
                fromY: 0,
                toY: data.reduce((a, b) => a > b ? a : b).toDouble(),
              ),
            ),
          ],
        ),
      )
      .toList();
}

FlGridData _buildGridData() {
  return FlGridData(
    show: true,
    horizontalInterval: 2,
    getDrawingHorizontalLine: (value) => FlLine(
      color: Colors.grey.shade300,
      strokeWidth: 1,
    ),
  );
}

FlBorderData _buildBorderData() {
  return FlBorderData(
    show: true,
    border: Border.all(
      color: Colors.grey.shade400,
      width: 1,
    ),
  );
}

BarTouchData _buildBarTouchData(List<String> sortedKeys) {
  return BarTouchData(
    touchTooltipData: BarTouchTooltipData(
      tooltipPadding: const EdgeInsets.all(6),
      tooltipRoundedRadius: 8.r,
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        return BarTooltipItem(
          '${sortedKeys[group.x.toInt()]}\n',
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeightHelper.bold,
          ),
          children: [
            TextSpan(
              text: 'Orders: ${rod.toY.toInt()}',
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeightHelper.regular,
              ),
            ),
          ],
        );
      },
    ),
  );
}
