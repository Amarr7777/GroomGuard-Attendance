import 'package:flutter/material.dart';
import 'package:frontend/home/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Attendance',
      theme: ThemeData(
        primaryColor: const Color(0xFF01B088),
        useMaterial3: true,
      ),
      home: const Homescreen()
    );
  }
}

