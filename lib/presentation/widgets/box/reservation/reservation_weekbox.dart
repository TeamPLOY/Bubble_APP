import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class ReservationWeekbox extends StatefulWidget {
  final String day;
  final String week;
  final bool isActive;
  final VoidCallback onTap;

  const ReservationWeekbox({
    required this.day,
    required this.week,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  @override
  State<ReservationWeekbox> createState() => _ReservationWeekboxState();
}

class _ReservationWeekboxState extends State<ReservationWeekbox> {
  @override
  Widget build(BuildContext context) {
    String day = widget.day.split('-').last;
    day = int.parse(day).toString();

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * (160 / 393),
        height: MediaQuery.of(context).size.height * (59 / 852),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 3,
            ),
          ],
          border: Border.all(
            color: widget.isActive ? AppColor.blue400 : AppColor.gray300,
            width: 1, // 테두리 굵기 설정
          ),
          borderRadius: BorderRadius.circular(10),
          color: widget.isActive
              ? AppColor.blue400
              : AppColor.white100, // 기본 배경색 흰색
        ),
        child: Center(
          child: Text(
            '$day일 ${widget.week}요일',
            style: AppTextStyles.medium18.copyWith(
              color: widget.isActive ? AppColor.white100 : AppColor.gray700,
            ),
          ),
        ),
      ),
    );
  }
}
