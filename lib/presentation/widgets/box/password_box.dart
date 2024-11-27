import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordBox extends StatefulWidget {
  PasswordBox({
    required this.wsize,
    required this.hsize,
    required this.text,
    required this.controller,
    super.key,
  });

  final TextEditingController controller;
  final double wsize, hsize;
  final String text;

  @override
  State<PasswordBox> createState() => _PasswordBoxState();
}

class _PasswordBoxState extends State<PasswordBox> {
  bool ispasswrod = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (widget.wsize / 393),
      height: widget.hsize * 1.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: AppColor.gray300),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              obscureText: ispasswrod,
              controller: widget.controller,
              cursorColor: AppColor.gray600,
              style: AppTextStyles.medium18.copyWith(color: AppColor.gray800),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 11, left: 11),
                hintText: widget.text,
                hintStyle:
                    AppTextStyles.medium16.copyWith(color: AppColor.gray400),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                ispasswrod = !ispasswrod;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                ispasswrod ? 'assets/img/eye.svg' : 'assets/img/eye-off.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
