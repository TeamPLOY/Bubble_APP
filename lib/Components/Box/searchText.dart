import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';

class Searchtext extends StatelessWidget {
  const Searchtext({required this.text,super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8,),
        Text('${text}',style: medium12.copyWith(color: red100),)
      ],
    );
  }
}