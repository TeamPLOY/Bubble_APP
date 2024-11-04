import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
class Message extends StatelessWidget {
  const Message({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text(
          '${text}',
          style: AppTextStyles.medium12.copyWith(color: AppColor.red100),
        )
      ],
    );
  }
}
