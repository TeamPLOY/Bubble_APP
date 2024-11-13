import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class FullModal extends StatefulWidget {
  const FullModal({super.key});

  @override
  State<FullModal> createState() => _FullModalState();
}

class _FullModalState extends State<FullModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppColor.white100
        ),
        width: MediaQuery.of(context).size.width*(360/393),
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 17, left: 18),
              child: Text(
                '해당 날짜의 예약은 현재 모두 마감되었습니다.',
                style: AppTextStyles.medium14.copyWith(color: AppColor.gray800),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only( right: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Text(
                        '확인',
                        style: AppTextStyles.semiBold12.copyWith(color: Color(0xff1C4EFF)),
                      ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
