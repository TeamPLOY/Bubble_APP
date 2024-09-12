import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';

class OutputText extends StatelessWidget {
  final String text_label;
  OutputText({required this.text_label ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width-48,
        height: 36,
        decoration: BoxDecoration(
          color: gray200,
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 9),
              child: Text('${text_label}',style: regular14.copyWith(color: gray600),),
            ),
          ],
        ),
    );
  }
}