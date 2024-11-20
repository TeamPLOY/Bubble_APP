import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class UserfullModal extends StatefulWidget {
  const UserfullModal({super.key});

  @override
  State<UserfullModal> createState() => _UserfullModalState();
}

class _UserfullModalState extends State<UserfullModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppColor.white100),
        width: MediaQuery.of(context).size.width * (340 / 393),
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 14, left: 16),
              child: Text(
                '이미 예약 하셨습니다.\n다음 주에 진행해주세요!',
                style: AppTextStyles.medium16.copyWith(color: AppColor.gray800),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 21, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Text(
                        '확인',
                        style: AppTextStyles.semiBold14
                            .copyWith(color: Color(0xff1C4EFF)),
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
