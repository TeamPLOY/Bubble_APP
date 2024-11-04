import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';

class ProfileText extends StatelessWidget {
  final String information;
  ProfileText({required this.information, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 48,
      height: 36,
      decoration: BoxDecoration(
          color: gray200, borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 9),
            child: Text(
              '${information}',
              style: regular14.copyWith(color: gray600),
            ),
          ),
        ],
      ),
    );
  }
}
