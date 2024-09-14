import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // flutter_svg 패키지 import
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Pages/main_page.dart';
import 'package:bubble_app/pages/my_page.dart';
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
                  MaterialPageRoute(builder: (context) => ReservationPage()),
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
                  MaterialPageRoute(builder: (context) => MainPage()),
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
                  MaterialPageRoute(builder: (context) => MyPage()),
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
