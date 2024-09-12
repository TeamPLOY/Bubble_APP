import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';

class StartPrint extends StatelessWidget {
  final String text;
  const StartPrint({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
          children: [
            Text('${text} ',style: medium16.copyWith(color: gray700),),
            Text('*',style: medium16.copyWith(color: red300),),
        ],
      ),
    );
  }
}