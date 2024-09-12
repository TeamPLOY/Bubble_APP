import 'package:bubble_app/theme.dart';
import 'package:flutter/material.dart';

class AnnoumentBox extends StatelessWidget {
  const AnnoumentBox({required this.text,required this.date,super.key});
  final String text;
  final String date;
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
            Text('${date}',style: medium12.copyWith(color:gray600),)
          ],
        ),
      ),
    );
  }
}