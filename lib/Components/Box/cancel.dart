import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Components/Modal/cancel_modal.dart';
class Cancel extends StatefulWidget {
  final String date;
  final String resDate;
  final String roomnumber;
  final bool cancel;
  final String washingRoom;

  Cancel({required this.date, required this.resDate, required this.roomnumber, required this.cancel, required this.washingRoom, Key? key}) : super(key: key);

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

  String todate(String date) {
    late String ymd = date.substring(0, 4) +
        '년 ' +
        date.substring(5, 7) +
        '월 ' +
        date.substring(8, 10) + '일';

    return ymd;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (332 / 393),
      height: 72,
      decoration: BoxDecoration(
        color: white100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: gray300,
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
              decoration: BoxDecoration(color: blue400, borderRadius: BorderRadius.circular(3)),
              alignment: Alignment.center,
              child: Text(
                "${widget.roomnumber}",
                style: medium10.copyWith(
                  color: white100,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12, top: 13),
                  child: Text(
                    "${todate(widget.date)} 예약",
                    style: medium14.copyWith(
                      color: gray800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: _cancel == true
                      ? Container(
                          width: 70,
                          height: 26,
                          decoration: BoxDecoration(
                            color: gray200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '사용 완료',
                              style: medium14.copyWith(color: gray500),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            final result = await showDialog(
                              context: context,
                              builder: (context) {
                                return CancelModal(
                                  roomnumber: widget.roomnumber,
                                  date: widget.date,
                                  cancel: widget.cancel,
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
                              color: gray200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '예약 취소',
                                style: semiBold14.copyWith(color: blue400),
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
