import 'package:flutter/material.dart';
import 'package:bubble_app/presentation/widgets/modal/reservation_cancel_modal.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';

class Cancel extends StatefulWidget {
  final String resDate;
  final String roomnumber;
  final bool cancel;
  final String washingRoom;
  final String dayOfWeek;
  final String machine;
  Cancel(
      {required this.resDate,
      required this.roomnumber,
      required this.cancel,
      required this.washingRoom,
      required this.dayOfWeek,
      required this.machine,
      Key? key})
      : super(key: key);

  @override
  State<Cancel> createState() => _CancelState();
}

class _CancelState extends State<Cancel> {
  late bool _cancel;

  @override
  void initState() {
    super.initState();
    _cancel = widget.cancel;
  }

bool checkDate(String backendDate) {
  String formattedDate = backendDate
      .replaceAll('년 ', '-')
      .replaceAll('월 ', '-')
      .replaceAll('일', '');
  DateTime parsedDate = DateTime.parse(formattedDate);

  DateTime today = DateTime.now();
  DateTime onlyToday = DateTime(today.year, today.month, today.day);
  DateTime onlyParsedDate = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

  if (onlyParsedDate == onlyToday) {
    return false;
  } else if (onlyParsedDate.isBefore(onlyToday)) {
    return true;
  } else if (onlyParsedDate.isAfter(onlyToday)) {
    return false;
  }

  throw Exception("Invalid date format");
}


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (332 / 393),
      height: 72,
      decoration: BoxDecoration(
        color: AppColor.white100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: AppColor.gray300,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16, top: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 16,
              decoration: BoxDecoration(
                  color: AppColor.blue400,
                  borderRadius: BorderRadius.circular(3)),
              child: Center(
                child: Text(
                  "${widget.machine}",
                  style: AppTextStyles.medium10.copyWith(
                    color: AppColor.white100,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "${widget.resDate} ${widget.dayOfWeek} 예약",
                    style: AppTextStyles.medium14.copyWith(
                      color: AppColor.gray800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 5),
                  child: _cancel == true
                      ? Container(
                          width: 70,
                          height: 26,
                          decoration: BoxDecoration(
                            color: AppColor.gray200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '취소 완료',
                              style: AppTextStyles.medium14
                                  .copyWith(color: AppColor.gray500),
                            ),
                          ),
                        )
                      : checkDate(widget.resDate)
                          ? Container(
                              width: 70,
                              height: 26,
                              decoration: BoxDecoration(
                                color: AppColor.gray200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '사용 완료',
                                  style: AppTextStyles.medium14
                                      .copyWith(color: AppColor.gray500),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                final result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ReservationCancelModal(
                                      roomnumber: widget.roomnumber,
                                      date: widget.resDate,
                                      cancel: widget.cancel,
                                      machine : widget.machine
                                    );
                                  },
                                );

                                if (result != null && result == true) {
                                  print(result);
                                  setState(() {
                                    _cancel = result;
                                  });
                                }
                              },
                              child: Container(
                                width: 70,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: AppColor.gray200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '예약 취소',
                                    style: AppTextStyles.semiBold14
                                        .copyWith(color: AppColor.blue400),
                                  ),
                                ),
                              ),
                            ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
