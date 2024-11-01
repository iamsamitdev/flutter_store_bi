import 'package:flutter/material.dart';
import 'package:flutter_store/dashboard.dart';
import 'package:flutter_store/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

var initRoute;

void main() async {

  // ต้องเรียกใช้ WidgetsFlutterBinding.ensureInitialized()
  // เพื่อให้สามารถเรียกใช้ SharedPreferences ได้
  WidgetsFlutterBinding.ensureInitialized();

  // เรียกใช้ SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // เช็คว่าถ้ามี token หรือไม่
  if (prefs.getString('token') != null) {
    initRoute = const Dashboard();
  } else {
    initRoute = const Home();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: false,
      ),
      home: initRoute,
    );
  }
}

