import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class EmailBox extends StatelessWidget {
  EmailBox({required this.wsize,required this.hsize,super.key});
  final double wsize, hsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (wsize / 393),
      height: hsize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color:AppColor.gray300),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8),
        child: Text('bssm.hs.kr',style:AppTextStyles.medium14.copyWith(color: AppColor.gray800)),
      )
    );
  }
}
