import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
// import 'package:bubble_app/pages/Alarm_page/Alarm_page.dart';
// import 'package:bubble_app/pages/Alarm_page/Notice_page.dart';
// import 'package:bubble_app/pages/Alarm_page/Reservation_page.dart';

class AlarmButton extends StatefulWidget {
  final int selectedButtonIndex;
  final Function(int) onButtonPressed;

  const AlarmButton({
    super.key,
    required this.selectedButtonIndex,
    required this.onButtonPressed,
  });

  @override
  _AlarmButtonState createState() => _AlarmButtonState();
}

class _AlarmButtonState extends State<AlarmButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomButton(
              text: '알림',
              isSelected: widget.selectedButtonIndex == 0,
              onPressed: () => widget.onButtonPressed(0),
            ),
            SizedBox(width: 10,),
            CustomButton(
              text: '공지사항',
              isSelected: widget.selectedButtonIndex == 1,
              onPressed: () => widget.onButtonPressed(1),
            ),
            SizedBox(width: 10,),
            CustomButton(
              text: '예약 목록',
              isSelected: widget.selectedButtonIndex == 2,
              onPressed: () => widget.onButtonPressed(2),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? blue400 : white100,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? blue400 : white100,
            width: 0.3,
          ),
        ),
        child: Text(
          text,
          style: regular14.copyWith(
            color: isSelected ? white100 : gray500,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
