import 'package:bubble_app/pages/Alarm_page/Alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/theme.dart';
// import 'package:bubble_app/Pages/main_page.dart';
import 'package:bubble_app/Pages/My_page.dart';
import 'package:bubble_app/Pages/reservationpage.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: white100,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => ReservationPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return child; // 애니메이션 없이 바로 화면 전환
                      },
                  ),
                );
              },
              icon: SvgPicture.asset(
                'assets/img/calendar.svg',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {
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
              icon: SvgPicture.asset(
                'assets/img/home.svg',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => MyPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return child; // 애니메이션 없이 바로 화면 전환
                      },
                  ),
                );
              },
              icon: SvgPicture.asset(
                'assets/img/Me.svg',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
