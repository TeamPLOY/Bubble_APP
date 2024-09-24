import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';

class GoButton extends StatelessWidget {
  final String text;
  const GoButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 48,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: blue400,
      ),
      child: Center(
        child: Text(
          "${text}",
          style: bold16.copyWith(color: white100),
        ),
      ),
    );
  }
}