import 'package:bubble_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Finish extends StatelessWidget {
  const Finish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/img/finish.svg',
              width: 150,
              height: 170,
            ),
            SizedBox(
              height: 20,
            ),
            Text("예약이 완료되었습니다!", style: bold28.copyWith(color: gray800)),
            SizedBox(
              height: 8,
            ),
            Text("3초 후 자동으로 꺼집니다.", style: medium14.copyWith(color: gray500)),
          ],
        ),
      ),
    );
  }
}
