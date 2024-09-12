import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/pages/main_page.dart';
import 'package:bubble_app/pages/Alarm_page/Alarm_page.dart';

class MainHeader extends StatelessWidget {
  final bool hasAlarm;

  const MainHeader({super.key, required this.hasAlarm});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.5, color: Color(0xffF2F5F7)),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: SvgPicture.asset(
                'assets/img/logo.svg',
                width: 8,
                height: 18,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 200),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AlarmPage()),
                  );
                },
                child: SvgPicture.asset(
                  hasAlarm
                      ? 'assets/images/alarm_yes.svg'
                      : 'assets/images/alarm_no.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
