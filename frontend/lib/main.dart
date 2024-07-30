import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:frontend/Login/login_screen.dart';
import 'package:frontend/home/HomeScreen.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Attendance',
      theme: ThemeData(
        primaryColor: const Color(0xFF01B088),
        useMaterial3: true,
      ),
      // home: HomeScreen(cameras: cameras),
      home: const LoginScreen(),
    );
  }
}
