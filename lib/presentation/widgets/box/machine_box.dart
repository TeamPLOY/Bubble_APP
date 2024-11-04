import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'dart:async';
import 'package:bubble_app/data/providers/network/apis/machine/machine_check_api.dart';
import 'package:bubble_app/data/providers/network/apis/machine/machine_alarm_api.dart';

class MachineBox extends StatefulWidget {
  late int hour, minute, place;
  late String device;

  MachineBox(
      {required this.place,
      required this.hour,
      required this.minute,
      required this.device,
      super.key});

  @override
  State<MachineBox> createState() => _MachineBoxState();
}

class _MachineBoxState extends State<MachineBox> {
  late bool alram_onff;
  late String alram_url = 'assets/img/alarm_no.svg';
  late Timer _timer;
  late MachineAlarmApi machineSave = MachineAlarmApi(machine: widget.device);

  @override
  void initState() {
    super.initState();
    setcheck();
    _startTimer();
  }

  void setcheck() async {
    MachingCheckApi machingCheck = MachingCheckApi(machine: widget.device);
    alram_onff = await machingCheck.checkpostData();
    alram_url =
        alram_onff ? 'assets/img/alarm_no.svg' : 'assets/img/alarm_x.svg';
    setState(() {}); // 값을 가져온 후 UI 업데이트
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
            _timer.cancel(); // 타이머 종료
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

  void alramchange() async {
    setState(() {
      if (alram_onff == false) {
        alram_url = 'assets/img/alarm_no.svg';
        alram_onff = true;
      } else if (alram_onff == true) {
        alram_url = 'assets/img/alarm_x.svg';
        alram_onff = false;
      }
    });
    await machineSave.savepostData();
    print("끝");
  }

  @override
  Widget build(BuildContext context) {
    // 화면 크기 가져오기
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.4; // 40% 너비로 설정
    final height = size.height * 0.15; // 15% 높이로 설정

    // 글자 크기 설정 (비율에 따라 조정)
    final titleSize = width * 0.05; // 제목 글자 크기
    final subtitleSize = width * 0.04; // 부제목 글자 크기
    final timeSize = width * 0.04; // 시간 글자 크기

    return Container(
      width: size.width * 0.4, // 너비를 반응형으로 설정
      height: size.height * 0.15, // 높이도 반응형으로 설정
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
                        '${widget.device}',
                        style: AppTextStyles.medium14.copyWith(
                            color: AppColor.gray800, fontSize: titleSize),
                      ),
                      Lightbox(selectedIndex: widget.place),
                    ],
                  ),
                  GestureDetector(
                      onTap: () => {alramchange()},
                      child: SvgPicture.asset(
                        alram_url,
                        width: width * 0.1,
                        height: height * 0.1,
                      )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: height * 0.1),
                child: Row(
                  children: [
                    Text(
                      '${widget.device}',
                      style: AppTextStyles.medium10.copyWith(
                          color: AppColor.gray800, fontSize: subtitleSize),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Container(
                      width: width * 0.02,
                      height: width * 0.02,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.hour == 0 && widget.minute == 0
                              ? AppColor.gray300
                              : AppColor.red100),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: height * 0.1),
              child: Row(
                children: [
                  Container(
                    width: width * 0.8,
                    height: height * 0.25,
                    decoration: BoxDecoration(
                        color: AppColor.gray200,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.05),
                          child: Text(
                            '${formattime(widget.hour)}:${formattime(widget.minute)}',
                            style: AppTextStyles.medium12.copyWith(
                                color: AppColor.gray400, fontSize: timeSize),
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

class Lightbox extends StatelessWidget {
  final int selectedIndex;

  const Lightbox({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dotSize = size.width * 0.01; // dot 크기를 화면 크기에 맞춰 설정

    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.02),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.03),
            child: Row(
              children: List.generate(2, (index) {
                int number = index + 1;
                return Padding(
                  padding: EdgeInsets.only(right: dotSize * 0.2),
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
          ),
          Row(
            children: List.generate(4, (index) {
              int number = index - 3;
              return Padding(
                padding: EdgeInsets.only(right: dotSize * 0.2),
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
