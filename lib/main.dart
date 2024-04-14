import 'package:flutter/material.dart';
import 'package:ui_samples/constant/ui_const.dart';
import 'package:ui_samples/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
