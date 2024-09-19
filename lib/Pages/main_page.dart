import 'package:bubble_app/Components/Box/bubblebox.dart';
import 'package:bubble_app/Components/Header/main_header.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/Components/Header/header.dart';
// import 'package:bubble_app/Components/Footer/footer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          MainHeader(hasAlarm: true),
          Bubblebox(
            place: 1,
            hour: 01,
            minute: 23,
            device: "세탁가",
          ),
        ],
      )),
    );
  }
}
