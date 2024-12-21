import 'package:flutter/material.dart';
import 'package:lecture_2/config/route/routes.dart';
import 'package:lecture_2/views/screens/home_screen.dart';
import 'package:lecture_2/views/screens/login_screen.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
