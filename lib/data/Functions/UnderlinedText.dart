import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class UnderlinedText extends StatelessWidget {
  final String text;

  UnderlinedText({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(
      text: text,
      style: AppTextStyles.medium12.copyWith(color: AppColor.red100)
    );

    return Stack(
      children: [
        Text.rich(
          textSpan,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 1,
            color: AppColor.red100,
            margin: EdgeInsets.only(top: 1),
          ),
        ),
      ],
    );
  }
}