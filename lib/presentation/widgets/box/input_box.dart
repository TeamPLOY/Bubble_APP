import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class Inputbox extends StatelessWidget {
  Inputbox(
      {required this.wsize,
      required this.hsize,
      required this.text,
      required this.controller,
      this.password,
      super.key});
  final bool? password;
  final TextEditingController controller;
  final double wsize, hsize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (wsize / 393),
      height: hsize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: AppColor.gray300),
      ),
      child: TextFormField(
        obscureText: password == true ? true : false,
        controller: controller,
        cursorColor: AppColor.gray600,
        style: AppTextStyles.medium18.copyWith(color: AppColor.gray800),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 11, left: 11),
          hintText: text,
          hintStyle: AppTextStyles.medium16.copyWith(color: AppColor.gray400),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
