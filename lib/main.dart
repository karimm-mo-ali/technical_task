import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/networking/order_model.dart';
import 'core/routing/app_router.dart';
import 'features/welcome_screen/ui/welcome_screen.dart';

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
        theme: ThemeData(
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        onGenerateRoute: appRouter.generateRoute,
        home: WelcomeScreen(orders: orders),
      ),
    );
  }
}
