import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        width: MediaQuery.of(context).size.width * (346 / 393),
        height: 227,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 23,),
            SvgPicture.asset('assets/img/modal.svg'),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '세탁기',
                  style: AppTextStyles.bold16.copyWith(color: AppColor.blue400),
                ),
                Text(
                  '와 ',
                  style: AppTextStyles.bold16.copyWith(color: AppColor.gray800),
                ),
                Text(
                  '날짜',
                  style: AppTextStyles.bold16.copyWith(color: AppColor.blue400),
                ),
                Text(
                  '를 선택해주세요.',
                  style: AppTextStyles.bold16.copyWith(color: AppColor.gray800),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Container(
                        width: 140,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColor.blue400,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        
                        child: Center(
                          child: Text(
                            '확인',
                            style: AppTextStyles.regular16
                                .copyWith(color:AppColor.white100),
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
