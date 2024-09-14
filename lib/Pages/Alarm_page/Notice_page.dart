import 'package:flutter/material.dart';
import 'package:bubble_app/components/Header/header.dart';
import 'package:bubble_app/components/Button/alarm.dart';
import 'package:bubble_app/pages/Alarm_page/Alarm_page.dart';
import 'package:bubble_app/pages/Alarm_page/Reservation.dart';
import 'package:bubble_app/Components/Box/cancel.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  int _selectedButtonIndex = 1;

  void _handleButtonPress(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => AlarmPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Reservation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(text: "공지사항"),
            AlarmButton(
              selectedButtonIndex: _selectedButtonIndex,
              onButtonPressed: _handleButtonPress,
            ),
            SizedBox(
              height: 26,
            ),
            Cancel("A", 2, "f", "F"),
          ],
        ),
      ),
    );
  }
}
