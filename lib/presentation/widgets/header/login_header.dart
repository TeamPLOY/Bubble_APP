import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class LoginHeader extends StatelessWidget {
  late String text;
  LoginHeader({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54,
      decoration: BoxDecoration(
          color: AppColor.white100,
          border: Border(
            bottom: BorderSide(width: 1.5, color: Color(0xffF2F5F7)),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          Text(
            '${text}',
            style: AppTextStyles.medium16.copyWith(color: AppColor.gray800),
          )
        ],
      ),
    );
  }
}
