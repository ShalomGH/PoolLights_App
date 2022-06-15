import 'package:flutter/material.dart';

import 'package:flutter_first/screens/main_page.dart';
import 'package:flutter_first/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
