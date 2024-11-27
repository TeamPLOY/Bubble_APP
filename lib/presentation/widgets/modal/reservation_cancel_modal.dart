import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/data/providers/network/apis/reservation/reservation_cancel_api.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReservationCancelModal extends StatelessWidget {
  final String roomnumber, date, machine;
  final bool cancel;
  const ReservationCancelModal(
      {required this.roomnumber,
      required this.machine,
      required this.date,
      required this.cancel,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppColor.white100),
        width: MediaQuery.of(context).size.width * (340 / 393),
        height: 227,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
            ),
            SvgPicture.asset('assets/img/Mark.svg'),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '예약을 ',
                  style: AppTextStyles.bold20.copyWith(color: AppColor.gray800),
                ),
                Text(
                  '취소',
                  style: AppTextStyles.bold20.copyWith(color: AppColor.blue400),
                ),
                Text(
                  '하시겠습니까?',
                  style: AppTextStyles.bold20.copyWith(color: AppColor.gray800),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '세탁기 이용을 하실 수 없습니다.',
              style: AppTextStyles.regular18.copyWith(color: AppColor.gray600),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () => {Navigator.pop(context, false)},
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColor.gray200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          '취소',
                          style: AppTextStyles.regular16
                              .copyWith(color: AppColor.gray700),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 12,
                ),
                GestureDetector(
                    onTap: () {
                      ReservationCancelApi cancelPost =
                          ReservationCancelApi(date: date);
                      cancelPost.fetchCancel();
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColor.blue400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          '확인',
                          style: AppTextStyles.regular16
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
