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
    const String message =
        "세탁실 깨끗하게 사용하세요!";

    return LayoutBuilder(
      builder: (context, constraints) {
  final double availableWidth = MediaQuery.of(context).size.width - 48;
  
  final TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: message,
      style: AppTextStyles.medium14.copyWith(color: AppColor.gray600),
    ),
    maxLines: 2,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: availableWidth);

  final bool isOverflow = textPainter.didExceedMaxLines;

  final double containerHeight = isOverflow ? 57 : 37;

  return Container(
    width: availableWidth,
    height: containerHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColor.gray200,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Text(
      message,
      style: AppTextStyles.medium14.copyWith(color: AppColor.gray600),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

    );
  }
}
