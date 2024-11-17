import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'dart:async';

import 'package:bubble_app/data/providers/network/apis/machine/machine_alarm_api.dart';

class MachineBox extends StatefulWidget {
  final int hour, minute, place;
  final String device;

  MachineBox({
    required this.place,
    required this.hour,
    required this.minute,
    required this.device,
  });

  @override
  State<MachineBox> createState() => _MachineBoxState();
}

class _MachineBoxState extends State<MachineBox> {
  bool alram_onff = false; // 알람 상태
  String alram_url = 'assets/img/alarm_no.svg'; // 알람 아이콘 URL
  Timer? _timer;
  late MachineAlarmApi machineSave =
      MachineAlarmApi(machine: widget.device); // 알람 데이터 API

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel(); // 타이머 해제
    super.dispose();
  }

  String formattime(int time) {
    return time.toString().padLeft(2, '0'); // 시간을 두 자릿수로 포맷
  }

  String getDeviceName() {
    // 화면에 표시할 기계 이름만 잘라서 반환
    List<String> parts = widget.device.split(' ');
    for (String part in parts) {
      if (part.contains('세탁기') || part.contains('건조기')) {
        return part; // 세탁기 또는 건조기만 표시
      }
    }
    return parts.last; // 다른 부분은 그대로 출력
  }

  void alramchange() async {
    setState(() {
      alram_onff = !alram_onff;
      alram_url = alram_onff
          ? 'assets/img/alarm_no.svg'
          : 'assets/img/alarm_x.svg'; // 알람 상태 변경
    });
    await machineSave.savepostData(); // 서버로 데이터 전송
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final boxWidth = size.width * 0.42;
    final boxHeight = boxWidth * 0.8;
    final titleSize = boxWidth * 0.1;
    final subtitleSize = boxWidth * 0.08;
    final timeSize = boxWidth * 0.12;

    return Container(
      width: boxWidth,
      height: boxHeight,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColor.gray300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(boxWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        getDeviceName(), // 표시할 기계 이름
                        style: AppTextStyles.medium14.copyWith(
                          color: AppColor.gray800,
                          fontSize: titleSize,
                        ),
                      ),
                      Lightbox(
                        selectedIndex: widget.place,
                        dotSize: boxWidth * 0.03,
                        spacing: boxWidth * 0.01,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  getDeviceName(), 
                  style: AppTextStyles.medium10.copyWith(
                    color: AppColor.gray800,
                    fontSize: subtitleSize,
                  ),
                ),
                SizedBox(width: boxWidth * 0.03),
                Container(
                  width: boxWidth * 0.03,
                  height: boxWidth * 0.03,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.hour == 0 && widget.minute == 0
                        ? AppColor.gray300
                        : AppColor.red100,
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: boxHeight * 0.3,
              decoration: BoxDecoration(
                color: AppColor.gray200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${formattime(widget.hour)}:${formattime(widget.minute)}', // 시간 표시
                  style: AppTextStyles.medium12.copyWith(
                    color: AppColor.gray400,
                    fontSize: timeSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Lightbox extends StatelessWidget {
  final int selectedIndex;
  final double dotSize;
  final double spacing;

  const Lightbox({
    super.key,
    required this.selectedIndex,
    required this.dotSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: spacing * 2),
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
              int number = index - 3;
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
