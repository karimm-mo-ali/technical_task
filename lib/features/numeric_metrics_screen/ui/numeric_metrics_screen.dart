import 'package:flutter/material.dart';
import '../../../core/networking/order_model.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Metrics Overview',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              const Text(
                'Key Insights',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Get a quick overview of your data metrics',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              // Metrics Cards Section
              MetricCard(
                icon: Icons.shopping_bag_rounded,
                color: Colors.blue,
                label: 'Total Orders',
                value: totalOrders.toString(),
              ),
              const SizedBox(height: 16),
              MetricCard(
                icon: Icons.attach_money,
                color: Colors.green,
                label: 'Average Price',
                value: '\$${averagePrice.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 16),
              MetricCard(
                icon: Icons.autorenew,
                color: Colors.red,
                label: 'Returns',
                value: returnsCount.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const MetricCard({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // Add meaningful interactivity if needed
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            children: [
              // Icon with Background
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 20),
              // Label and Value
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
