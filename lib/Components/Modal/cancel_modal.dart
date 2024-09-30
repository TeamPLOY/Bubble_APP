import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Utils/cancel_post.dart';
class CancelModal extends StatelessWidget {
  final String roomnumber, date;
  final bool cancel;
  const CancelModal({required this.roomnumber, required this.date, required this.cancel, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * (332 / 393),
        height: 109,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: white100
        ),
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
                  decoration: BoxDecoration(color: blue400, borderRadius: BorderRadius.circular(3)),
                  alignment: Alignment.center,
                  child: Text(
                    "${roomnumber}",
                    style: medium10.copyWith(
                      color: white100,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text('예약을 취소하시겠습니까?', style: medium14.copyWith(color: gray800)),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('예약을 취소하시면 사용하실 수 없습니다.', style: medium8.copyWith(color: gray500)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        child: Container(
                          width: 62,
                          height: 20,
                          decoration: BoxDecoration(
                              color: gray200,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Text('아니요', style: medium10.copyWith(color: gray500)),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                          CancelPost cancelPost=CancelPost(date: date);
                          cancelPost.fetchCancel();
                        },
                        child: Container(
                          width: 62,
                          height: 20,
                          decoration: BoxDecoration(
                              color: gray200,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Text('네', style: medium10.copyWith(color: gray500)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14,
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
