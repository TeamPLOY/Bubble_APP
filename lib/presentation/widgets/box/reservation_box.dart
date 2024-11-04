import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class ReservationBox extends StatefulWidget {
  const ReservationBox({
    required this.today,
    required this.userCount,
    required this.onStateChanged,
    required this.isSelected,
    super.key,
  });

  final DateTime today;
  final int userCount;
  final ValueChanged<bool> onStateChanged;
  final bool isSelected;

  @override
  State<ReservationBox> createState() => _ReservationBoxState();
}

class _ReservationBoxState extends State<ReservationBox> {
  late Color boxColor;

  @override
  void initState() {
    super.initState();
    initDateFormat();
    boxColor = widget.isSelected ? AppColor.blue300 : AppColor.gray500;
  }

  void initDateFormat() async {
    await initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onStateChanged(!widget.isSelected);
      },
      child: Container(
        width: 140,
        height: 107,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? Colors.lightBlue.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9.33),
          border: Border.all(
            width: 1.5,
            color: widget.isSelected ? AppColor.blue300 : AppColor.gray500,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat('M월d일').format(widget.today),
              style: AppTextStyles.medium16.copyWith(
                  color: widget.isSelected ? AppColor.blue300 : AppColor.gray500),
            ),
            SizedBox(height: 4),
            Text(
              DateFormat('EEEE', 'ko_KR').format(widget.today),
              style: AppTextStyles.medium16.copyWith(
                  color: widget.isSelected ? AppColor.blue300 : AppColor.gray500),
            ),
          ],
        ),
      ),
    );
  }
}
