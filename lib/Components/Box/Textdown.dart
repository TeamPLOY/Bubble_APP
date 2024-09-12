import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';

class Textdown extends StatelessWidget {
  const Textdown({required this.text,super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 14,),
        Container(
          width: MediaQuery.of(context).size.width * (296 / 393),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: gray100,
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: [
                Text('${text}',style: semiBold14.copyWith(color: gray600),)
              ],
            ),
          ),
        )
      ],
    );
  }
}