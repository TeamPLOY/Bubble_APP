import 'dart:async';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Pages/Alarm_page/Alarm_page.dart'; // 알림 페이지 import
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Finish extends StatefulWidget {
  final String title;
  const Finish({required this.title, Key? key})
      : super(key: key); // 수정: title과 Key 설정

  @override
  State<Finish> createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  Timer? _timer;
  int count = 3; // 변수명을 count로 변경

  @override
  void initState() {
    super.initState();

    // 1초마다 남은 시간을 줄이는 Timer 설정
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count > 1) {
        setState(() {
          count--; // 매 초마다 남은 시간을 1씩 줄임
        });
      } else {
        // 0초가 되면 알림 페이지로 이동
        timer.cancel(); // 타이머 취소
          Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => AlarmPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return child; // 애니메이션 없이 바로 화면 전환
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Timer가 있으면 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/img/finish.svg',
                width: 84,
                height: 84,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${widget.title}이 완료되었습니다!",
                style: bold28.copyWith(color: gray800),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "$count초 후 알림 페이지로 이동합니다.",
                style: medium14.copyWith(color: gray500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
