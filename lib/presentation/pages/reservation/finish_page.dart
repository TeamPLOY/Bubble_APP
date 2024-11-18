import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/pages/alarm/alarm_page.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({super.key});

  @override
  State<FinishPage> createState() => _FinishState();
}

class _FinishState extends State<FinishPage> {
  Timer? _timer;
  int count = 3;

  @override
  void initState() {
    super.initState();

    // 1초마다 남은 시간을 줄이는 Timer 설정
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count > 1) {
        setState(() {
          count--;
        });
      } else {
        timer.cancel(); // 타이머 취소
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
      backgroundColor: AppColor.white100,
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
                "예약이 완료되었습니다!",
                style: AppTextStyles.bold28
                    .copyWith(color: AppColor.gray800), // 색상 수정
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "$count초 후 알림 페이지로 이동합니다.",
                style: AppTextStyles.medium14
                    .copyWith(color: AppColor.gray600), // 색상 수정
              ),
            ],
          ),
        ),
      ),
    );
  }
}
