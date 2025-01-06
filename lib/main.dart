import 'package:flutter/material.dart';
import 'package:lecture_2/config/route/router.dart';
import 'package:lecture_2/config/route/routes.dart';
import 'package:lecture_2/views/screens/login_screen.dart';
import 'views/screens/home_screen.dart';
import 'helpers/constants.dart';
import 'package:get/get.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      initialRoute: Routes.login,
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}
