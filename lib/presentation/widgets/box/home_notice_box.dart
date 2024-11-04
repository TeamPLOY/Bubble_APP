import 'package:bubble_app/theme.dart';
import 'package:flutter/material.dart';

class MainNoticeBox extends StatefulWidget {
  const MainNoticeBox({super.key});

  @override
  State<MainNoticeBox> createState() => _MainNoticeBoxState();
}

class _MainNoticeBoxState extends State<MainNoticeBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 48,
      height: 47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: gray100,
      ),
      padding: EdgeInsets.only(left: 13, top: 14),
      child: Text(
        "세탁기 섬유유연제는 두통을 유발하니 자제해주세요.",
        style: medium14.copyWith(color: gray500),
      ),
    );
  }
}
