import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
class UnderlinedText extends StatelessWidget {
  final String text;

  UnderlinedText({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(
      text: text,
      style: medium12.copyWith(color: red100)
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
            height: 1, // 밑줄의 두께를 설정합니다.
            color: red100,
            margin: EdgeInsets.only(top: 1),
          ),
        ),
      ],
    );
  }
}