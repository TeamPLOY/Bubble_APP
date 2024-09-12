import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
//콜백 함수로 box_state를 반환한다

class CheckBox extends StatefulWidget {
  const CheckBox({
    required this.week,
    required this.day,
    required this.onStateChanged,
    super.key,
  });

  final String week;
  final int day;
  final ValueChanged<int> onStateChanged;

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  int box_state = 0;
  Color box_color = gray500;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (box_state == 0) {
            box_state = 1;
            box_color = blue300;
          } else if (box_state == 1) {
            box_state = 0;
            box_color = gray500;
          }
          widget.onStateChanged(box_state);
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * (140 / 393),
        height: 107,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.33),
          border: Border.all(width: 1.5, color: box_color),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.day}일',
              style: medium16.copyWith(color: box_color),
            ),
            SizedBox(height: 4),
            Text(
              '${widget.week}요일',
              style: medium16.copyWith(color: box_color),
            ),
          ],
        ),
      ),
    );
  }
}
