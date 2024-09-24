import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/theme.dart';
//import 'package:bubble_app/pages/main_page.dart';
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
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => AlarmPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return child; // 애니메이션 없이 바로 화면 전환
                      },
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/img/logo.svg',
                width: 71,
                height: 14,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 200),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => AlarmPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return child; // 애니메이션 없이 바로 화면 전환
                        },
                    ),
                  );
                },
                child: SvgPicture.asset(
                  hasAlarm
                      ? 'assets/img/alarm_yes.svg'
                      : 'assets/img/alarm_no.svg',
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
