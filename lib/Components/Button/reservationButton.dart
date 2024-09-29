import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';


class Reservationbutton extends StatelessWidget {
  final VoidCallback? onPressed;

  const Reservationbutton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width - 48,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: blue400,
        ),
        child: Center(
          child: Text(
            "예약하기",
            style: bold16.copyWith(color: white100),
          ),
        ),
      ),
    );
  }
}


