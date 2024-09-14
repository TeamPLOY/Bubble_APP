import 'package:flutter/material.dart';
import 'package:bubble_app/components/Header/header.dart';
import 'package:bubble_app/components/Button/alarm.dart';
import 'package:bubble_app/pages/Alarm_page/Notice_page.dart';
import 'package:bubble_app/pages/Alarm_page/Alarm_page.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  int _selectedButtonIndex = 2;

  void _handleButtonPress(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AlarmPage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoticePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(text: "예약 목록"),
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
