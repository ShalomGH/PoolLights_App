import 'package:flutter/material.dart';

import 'package:flutter_first/screens/main_page.dart';
import 'package:flutter_first/themes/light_theme.dart';

import 'funcs/functions.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pingDevice(context);
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
