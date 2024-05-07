import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/utils/routes/routes_names.dart';
import 'package:flutter_mvvm_provider/view/home_screen.dart';
import 'package:flutter_mvvm_provider/view/login_screen.dart';
import 'package:flutter_mvvm_provider/view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteNames.signup:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}
