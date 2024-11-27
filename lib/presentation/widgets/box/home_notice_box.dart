import 'package:bubble_app/data/models/notice_model.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'dart:async';

class MainNoticeBox extends StatefulWidget {
  const MainNoticeBox({required this.noticemodels, super.key});
  final List<Noticemodel> noticemodels;

  @override
  State<MainNoticeBox> createState() => _MainNoticeBoxState();
}

class _MainNoticeBoxState extends State<MainNoticeBox> {
  int currentIndex = 0;
  Timer? _timer;
  String message = '세탁실 청결을 유지해주세요!';
  @override
  void initState() {
    super.initState();
    _startTimer(); // 타이머 시작
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % widget.noticemodels.length;
        message = widget.noticemodels[currentIndex].title;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 타이머 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = MediaQuery.of(context).size.width - 48;

        return Container(
          width: availableWidth,
          height: 37, // 고정 높이 설정
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.gray200,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간
            switchInCurve: Curves.easeOutQuad, // 부드러운 인 애니메이션
            switchOutCurve: Curves.easeInQuad, // 부드러운 아웃 애니메이션
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5), // 시작 위치를 약간 더 아래로
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutQuad, // 부드러운 감속
                )),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: SizedBox(
              key: ValueKey<String>(message),
              width: double.infinity,
              child: Text(
                message,
                style: AppTextStyles.medium14.copyWith(color: AppColor.gray600),
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}
