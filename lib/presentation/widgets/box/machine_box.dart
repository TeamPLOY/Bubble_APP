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
    setState(() {});
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
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

  String getDeviceName() {
    // 공백으로 분리하고 '세탁기' 또는 '건조기'가 포함된 부분만 반환
    List<String> parts = widget.device.split(' ');
    for (String part in parts) {
      if (part.contains('세탁기') || part.contains('건조기')) {
        return part;
      }
    }
    return parts.last; // 해당하는 단어가 없는 경우 마지막 부분 반환
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final boxWidth = size.width * 0.35;
    final boxHeight = size.height * 0.12;

    final titleSize = boxHeight * 0.11;
    final subtitleSize = boxHeight * 0.09;
    final timeSize = boxHeight * 0.11;

    final horizontalPadding = boxWidth * 0.04;

    return Container(
      width: boxWidth,
      height: boxHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(boxHeight * 0.05),
          border: Border.all(width: 1, color: AppColor.gray300)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: boxHeight * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      getDeviceName(),
                      style: AppTextStyles.medium14.copyWith(
                          color: AppColor.gray800, fontSize: titleSize),
                    ),
                    Lightbox(
                      selectedIndex: widget.place,
                      dotSize: boxWidth * 0.012,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => alramchange(),
                  child: SvgPicture.asset(
                    alram_url,
                    width: boxWidth * 0.06,
                    height: boxHeight * 0.15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  getDeviceName(),
                  style: AppTextStyles.medium10.copyWith(
                      color: AppColor.gray800, fontSize: subtitleSize),
                ),
                SizedBox(width: boxWidth * 0.02),
                Container(
                  width: boxWidth * 0.015,
                  height: boxWidth * 0.015,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.hour == 0 && widget.minute == 0
                          ? AppColor.gray300
                          : AppColor.red100),
                )
              ],
            ),
            Container(
              width: boxWidth * 0.9,
              height: boxHeight * 0.28,
              decoration: BoxDecoration(
                color: AppColor.gray200,
                borderRadius: BorderRadius.circular(boxHeight * 0.04),
              ),
              child: Center(
                child: Text(
                  '${formattime(widget.hour)}:${formattime(widget.minute)}',
                  style: AppTextStyles.medium12
                      .copyWith(color: AppColor.gray400, fontSize: timeSize),
                ),
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
  final double dotSize;

  const Lightbox({
    super.key,
    required this.selectedIndex,
    required this.dotSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: dotSize * 2),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: dotSize * 3),
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
