import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class IsreservationModal extends StatefulWidget {
  const IsreservationModal({super.key});

  @override
  State<IsreservationModal> createState() => _IsreservationModalState();
}

class _IsreservationModalState extends State<IsreservationModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppColor.white100),
        width: MediaQuery.of(context).size.width * (340 / 393),
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                '세탁기를 선택해주세요.',
                style: AppTextStyles.medium14.copyWith(color: AppColor.gray800),
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
