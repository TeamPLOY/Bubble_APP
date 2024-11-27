import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class InputTitle extends StatelessWidget {
  final String text;
  const InputTitle({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '${text} ',
            style: AppTextStyles.medium16.copyWith(color: AppColor.gray700),
          ),
          Text(
            '*',
            style: AppTextStyles.medium16.copyWith(color: AppColor.red300),
          ),
        ],
      ),
    );
  }
}
