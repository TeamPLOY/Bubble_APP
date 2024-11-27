import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        width: MediaQuery.of(context).size.width * (300 / 393),
        height: 278,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            SvgPicture.asset(
              'assets/img/bluemark.svg',
              width: 70,
              height: 70,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '이미 예약하셨습니다.',
                  style:
                      AppTextStyles.medium20.copyWith(color: AppColor.gray800),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '다음주에 예약해주세요.',
              style: AppTextStyles.medium20.copyWith(color: AppColor.gray800),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () => {Navigator.of(context).pop()},
                    child: Container(
                      width: 254,
                      height: 45,
                      decoration: BoxDecoration(
                          color: AppColor.blue400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          '확인',
                          style: AppTextStyles.regular18
                              .copyWith(color: AppColor.white100),
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
