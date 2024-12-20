import 'package:flutter/material.dart';
import 'views/screens/home_screen.dart';
import 'helpers/constants.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      home: HomeScreen(),
    );
  }
}
