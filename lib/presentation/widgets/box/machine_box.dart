import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'dart:async';
import 'package:bubble_app/data/providers/network/apis/machine/machine_alarm_api.dart';

class MachineBox extends StatefulWidget {
  late int hour, minute, place;
  late String device;

  MachineBox({
    required this.place,
    required this.hour,
    required this.minute,
    required this.device,
    super.key,
  });

  @override
  State<MachineBox> createState() => _MachineBoxState();
}

class _MachineBoxState extends State<MachineBox> {
  late Timer _timer;
  late MachineAlarmApi machineSave = MachineAlarmApi(machine: widget.device);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        if (widget.minute > 0) {
          widget.minute--;
        } else {
          if (widget.hour > 0) {
            widget.hour--;
            widget.minute = 59;
          } else {
            _timer.cancel();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formattime(int time) {
    return time.toString().padLeft(2, '0');
  }

  /// 머신 이름 가공 함수
  String extractMachineName(String fullName) {
    List<String> parts = fullName.split(' ');
    return parts.length > 1 ? parts.last : fullName;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.4;
    final height = size.height * 0.15;

    final titleSize = width * 0.07;
    final subtitleSize = width * 0.055;
    final timeSize = width * 0.07;

    return Container(
      width: size.width * 0.8,
      height: MediaQuery.of(context).size.width >= 700
          ? size.height * 0.2
          : size.height * 0.16,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(width: 1, color: AppColor.gray300)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.1, right: width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        // 가공된 머신 이름을 표시
                        extractMachineName(widget.device),
                        style: MediaQuery.of(context).size.width <= 400
                            ? AppTextStyles.medium14.copyWith(
                                color: AppColor.gray800,
                                fontSize: titleSize * 1.6)
                            : AppTextStyles.medium14.copyWith(
                                color: AppColor.gray800, fontSize: titleSize),
                      ),
                      Lightbox(selectedIndex: widget.place),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.1),
              child: Row(
                children: [
                  Text(
                    '작동중',
                    style: MediaQuery.of(context).size.width <= 400
                        ? AppTextStyles.medium10.copyWith(
                            color: AppColor.gray800,
                            fontSize: subtitleSize * 1.6)
                        : AppTextStyles.medium10.copyWith(
                            color: AppColor.gray800, fontSize: subtitleSize),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width <= 350
                        ? width * 0.04
                        : width * 0.02,
                  ),
                  Container(
                    width: width * 0.05,
                    height: width * 0.05,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.hour == 0 && widget.minute == 0
                            ? AppColor.gray300
                            : AppColor.red100),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.1),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width <= 320
                        ? width * 0.8
                        : width * 0.9,
                    height: MediaQuery.of(context).size.width >= 700
                        ? height * 0.4
                        : MediaQuery.of(context).size.width >= 600
                            ? height * 0.3
                            : MediaQuery.of(context).size.width <= 400
                                ? height * 0.30
                                : height * 0.25,
                    decoration: BoxDecoration(
                      color: widget.hour == 0 && widget.minute == 0
                          ? AppColor.gray200 // 작동 중이지 않을 때 배경 설정
                          : Colors.transparent, // 작동 중일 때 배경 제거
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: widget.hour == 0 && widget.minute == 0
                            ? Colors.transparent // 작동 중이지 않을 때 테두리 제거
                            : AppColor.gray300, // 작동 중일 때 테두리 색상 설정
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.05),
                          child: Text(
                            '${formattime(widget.hour)} : ${formattime(widget.minute)}',
                            style: MediaQuery.of(context).size.width <= 400
                                ? AppTextStyles.medium22.copyWith(
                                    color: AppColor.gray600,
                                    fontSize: timeSize * 1.6)
                                : AppTextStyles.medium14.copyWith(
                                    color: AppColor.gray600,
                                    fontSize: timeSize),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Lightbox 위젯 정의
class Lightbox extends StatelessWidget {
  final int selectedIndex;
  final double dotSize;
  final double spacing;

  const Lightbox({
    super.key,
    required this.selectedIndex,
    this.dotSize = 6.0,
    this.spacing = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: spacing * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(2, (index) {
              int number = index + 1;
              return Padding(
                padding: EdgeInsets.only(right: spacing),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: selectedIndex == number
                        ? AppColor.blue400
                        : AppColor.blue100,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(4, (index) {
              int number = index + -3;
              return Padding(
                padding: EdgeInsets.only(right: spacing),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: selectedIndex == number
                        ? AppColor.blue400
                        : AppColor.blue100,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
