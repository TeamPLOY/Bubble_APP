import 'package:flutter/material.dart';
import 'package:bubble_app/Pages/Alarm_page/Alarm_page.dart';
import 'package:bubble_app/Pages/Alarm_page/Notice_page.dart';
import 'package:bubble_app/Pages/Alarm_page/Reservation.dart';
import 'package:bubble_app/Components/Header/header.dart';
import 'package:bubble_app/Components/Footer/footer.dart';
import 'package:bubble_app/Components/Button/Alarm.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  int _selectedButtonIndex = 0;

  void _handleButtonPress(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => NoticePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; // 애니메이션 없이 바로 화면 전환
          },
      ),
    );
    } else if (index == 2) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Reservation(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; // 애니메이션 없이 바로 화면 전환
          },
      ),
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(text: "알림"),
            AlarmButton(
              selectedButtonIndex: _selectedButtonIndex,
              onButtonPressed: _handleButtonPress,
            ),
          ],
        ),
      ),
    );
  }
}
