import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xffEBEEF1).withOpacity(0.3),
      ),
      alignment: Alignment.center,
      child: Text(
        "로그인",
        style: semiBold16.copyWith(
          color: white100,
        ),
      ),
    );
  }
}
