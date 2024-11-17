import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class MainNoticeBox extends StatefulWidget {
  const MainNoticeBox({super.key});

  @override
  State<MainNoticeBox> createState() => _MainNoticeBoxState();
}

class _MainNoticeBoxState extends State<MainNoticeBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 48,
      height: 57,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.gray200,
      ),
      padding: EdgeInsets.only(left: 10, top: 10,right: 10),
      child: Text(
        "세탁기 섬유유연제는 두통을 유발하니 자제해주세요.",
        style: AppTextStyles.medium14.copyWith(color: AppColor.gray600),
      ), 
    );
  }
}
