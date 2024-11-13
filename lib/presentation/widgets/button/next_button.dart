import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class NextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const NextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width - 48,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.blue400,
        ),
        child: Center(
          child: Text(
            '${text}',
            style: AppTextStyles.bold16.copyWith(color: AppColor.white100),
          ),
        ),
      ),
    );
  }
}
