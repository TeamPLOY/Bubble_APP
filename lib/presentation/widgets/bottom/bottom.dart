import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/presentation/pages/profile/profile_page.dart';
import 'package:bubble_app/presentation/pages/reservation/reservation_page.dart';
import 'package:bubble_app/presentation/pages/alarm/alarm_page.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.white100,
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
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ReservationPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
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
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AlarmPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ProfilePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
