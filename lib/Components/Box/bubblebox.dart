import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/theme.dart';
import 'dart:async';
import 'package:bubble_app/Utils/maching_check.dart';
import 'package:bubble_app/Utils/machine_save.dart';

class Bubblebox extends StatefulWidget {
  late int hour, minute, place;
  late String device;
  
  Bubblebox(
      {required this.place,
      required this.hour,
      required this.minute,
      required this.device,
      super.key});

  @override
  State<Bubblebox> createState() => _BubbleboxState();
}

class _BubbleboxState extends State<Bubblebox> {
  late bool alram_onff;
  late String alram_url='assets/img/alarm_no.svg';
  late Timer _timer;
  late MachineSave machineSave=MachineSave(machine: widget.device);

  @override
  void initState() {
    super.initState();
    setcheck();
    _startTimer();
  }
  void setcheck() async{
    MachingCheck machingCheck = MachingCheck(machine: widget.device);
    alram_onff = await machingCheck.checkpostData();
    alram_url = alram_onff ? 'assets/img/alarm_no.svg' : 'assets/img/alarm_x.svg';
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
    _timer.cancel(); // 위젯이 제거될 때 타이머를 취소
    super.dispose();
  }

  // 기존 build 메서드는 그대로 사용

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
      width: MediaQuery.of(context).size.width*(160/393),
      height: 113,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(width: 1, color: gray300)),
      child: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*(14/393)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 11, right: MediaQuery.of(context).size.width*(15.5/393)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${widget.device}',
                        style: medium14.copyWith(
                            color: gray800, fontSize: titleSize),
                      ),
                      Lightbox(selectedIndex: widget.place),
                    ],
                  ),
                  GestureDetector(
                      onTap: () => {alramchange()},
                      child: SvgPicture.asset(
                        alram_url,
                        width: 19,
                        height: 20,
                      )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 13),
                child: Row(
                  children: [
                    Text(
                      '${widget.device}',
                      style: medium10.copyWith(
                          color: gray800, fontSize: subtitleSize),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.hour == 0 && widget.minute == 0
                              ? gray300
                              : red100),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*(132/393),
                    height: 26,
                    decoration: BoxDecoration(
                        color: gray200, borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7),
                          child: Text(
                            '${formattime(widget.hour)}:${formattime(widget.minute)}',
                            style: medium12.copyWith(
                                color: gray400, fontSize: timeSize),
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
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: List.generate(2, (index) {
                int number = index + 1;
                return Padding(
                  padding: const EdgeInsets.only(right: 1, top: 1),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: selectedIndex == number ? blue400 : blue100,
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
                padding: const EdgeInsets.only(right: 1, top: 1),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: selectedIndex == number
                        ? blue400
                        : blue100, // 조건에 따라 색상 변경
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
