import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class NoticeBox extends StatelessWidget {
  NoticeBox({required this.text, required this.date, super.key});
  final String text;
  final String date;
  late String ymd = date.substring(0, 4) +
      '.' +
      date.substring(5, 7) +
      '.' +
      date.substring(8, 10);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (345 / 393),
      height: 84,
      decoration: BoxDecoration(
          color: AppColor.white100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppColor.gray300)),
      child: Padding(
        padding: EdgeInsets.only(left: 17, top: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${text}',
              style: AppTextStyles.semiBold16.copyWith(color: AppColor.gray800),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${ymd}',
              style: AppTextStyles.medium14.copyWith(color: AppColor.gray600),
            )
          ],
        ),
      ),
    );
  }
}
