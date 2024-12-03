import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/networking/order_model.dart';
import 'core/routing/app_router.dart';
import 'core/helpers/extensions.dart';
import 'core/routing/routes.dart';
import 'core/theming/font_weight_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  final orders = await fetchOrders();
  runApp(MyApp(
    orders: orders,
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final List<Order> orders;
  final AppRouter appRouter;
  const MyApp({super.key, required this.orders, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        onGenerateRoute: appRouter.generateRoute,
        home: HomeScreen(orders: orders),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Order> orders;

  const HomeScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FlapKap Challenge',
          style: TextStyle(fontWeight: FontWeightHelper.medium),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App Logo or Icon
            const Column(
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  size: 80,
                  color: Colors.blueAccent,
                ),
                SizedBox(height: 8),
                Text(
                  "Welcome to FlapKap Analytics",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  "Analyze and visualize your orders data with ease.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Buttons Section
            ElevatedButton(
              onPressed: () => context.pushNamed(
                Routes.numericMetricsScreen,
                arguments: {"orders": orders},
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.numbers_rounded, color: Colors.white),
                  SizedBox(width: 8),
                  Text('View Numeric Metrics',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.pushNamed(
                Routes.graphScreen,
                arguments: {"orders": orders},
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart_rounded),
                  SizedBox(width: 8),
                  Text('View Graph'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
