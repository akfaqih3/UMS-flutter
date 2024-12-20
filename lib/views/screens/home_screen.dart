import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var modeIcon = Icons.light_mode;
  var dark = Colors.black87;
  var light = Colors.white70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appName,
          style: TextStyle(color: light),
        ),
        backgroundColor: dark,
        actions: [
          FilledButton(
            child: Icon(modeIcon),
            onPressed: () {
              setState(() {
                if (modeIcon == Icons.light_mode) {
                  modeIcon = Icons.dark_mode;
                  dark = Colors.white70;
                  light = Colors.black87;
                } else {
                  modeIcon = Icons.light_mode;
                  light = Colors.white70;
                  dark = Colors.black87;
                }
              });
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          appAuthor,
          style: TextStyle(color: dark),
        ),
      ),
      backgroundColor: light,
    );
  }
}
