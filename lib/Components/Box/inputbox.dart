import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
class Inputbox extends StatelessWidget {

  Inputbox({required this.wsize, required this.hsize, required this.text, required this.controller,this.password,super.key});
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
        border: Border.all(width: 1, color: gray300),
      ),
      child: TextFormField(
        obscureText: password==true?true:false, 
        controller: controller,
        cursorColor: gray600,
        style: medium14.copyWith(color: gray800),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 11, left: 11),
          hintText: text,
          hintStyle: medium14.copyWith(color: gray400),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
