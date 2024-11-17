import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/data/providers/network/apis/reservation/reservation_cancel_api.dart';

class ReservationCancelModal extends StatelessWidget {
  final String roomnumber, date;
  final bool cancel;
  const ReservationCancelModal(
      {required this.roomnumber,
      required this.date,
      required this.cancel,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * (332 / 393),
        height: 109,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: AppColor.white100),
        child: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Container(
                  width: 70,
                  height: 16,
                  decoration: BoxDecoration(
                      color: AppColor.blue400,
                      borderRadius: BorderRadius.circular(3)),
                  alignment: Alignment.center,
                  child: Text(
                    "세탁실 ${roomnumber}",
                    style: AppTextStyles.medium10.copyWith(
                      color: AppColor.white100,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text('예약을 취소하시겠습니까?',
                    style: AppTextStyles.medium14
                        .copyWith(color: AppColor.gray800)),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('예약을 취소하시면 사용하실 수 없습니다.',
                      style: AppTextStyles.medium10
                          .copyWith(color: AppColor.gray600)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * (50 / 393),
                          height:
                              MediaQuery.of(context).size.height * (20 / 893),
                          decoration: BoxDecoration(
                              color: AppColor.gray200,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text('아니요',
                                style: AppTextStyles.medium10
                                    .copyWith(color: AppColor.gray600)),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                          ReservationCancelApi cancelPost =
                              ReservationCancelApi(date: date);
                          cancelPost.fetchCancel();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * (50 / 393),
                          height:
                              MediaQuery.of(context).size.height * (20 / 893),
                          decoration: BoxDecoration(
                              color: AppColor.gray200,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text('네',
                                style: AppTextStyles.medium10
                                    .copyWith(color: AppColor.gray600)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * (14 / 393),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
