import 'package:bubble_app/theme.dart';
import 'package:flutter/material.dart';

class AnnoumentBox extends StatelessWidget {
  AnnoumentBox({required this.text,required this.date,super.key});
  final String text;
  final String date;
  late String ymd = date.substring(0, 4) +
      '.' +
      date.substring(4, 6) +
      '.' +
      date.substring(6, 8);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (345 / 393),
      height: 84,
      child: Padding(
        padding: EdgeInsets.only(left: 17,top: 27),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${text}',style: semiBold14.copyWith(color: gray800),),
            SizedBox(height: 5,),
            Text('${ymd}',style: medium12.copyWith(color:gray600),)
          ],
        ),
      ),
    );
  }
}