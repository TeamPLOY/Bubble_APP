import 'package:bubble_app/Components/Button/login.dart';
import 'package:bubble_app/Pages/my_page.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/Pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
