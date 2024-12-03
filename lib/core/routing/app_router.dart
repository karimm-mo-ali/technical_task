import 'package:flutter/material.dart';
import '../../features/graph_screen/ui/graph_screen.dart';
import '../../features/numeric_metrics_screen/ui/numeric_metrics_screen.dart';
import '../networking/order_model.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.numericMetricsScreen:
        if (arguments is Map<String, dynamic>) {
          final orders = arguments['orders'] as List<Order>? ?? [];
          return MaterialPageRoute(
            builder: (_) => NumericMetricsScreen(orders: orders),
          );
        }
        return _errorRoute();

      case Routes.graphScreen:
        if (arguments is Map<String, dynamic>) {
          final orders = arguments['orders'] as List<Order>? ?? [];
          return MaterialPageRoute(
            builder: (_) => GraphScreen(orders: orders),
          );
        }
        return _errorRoute();

      default:
        return null;
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Error: Route Not Found!'),
        ),
      ),
    );
  }
}
