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

  // New method to determine if the current device is an iPad
  bool get _isIPad {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= 600 && shortestSide < 1024;
  }

  // New method to determine if the current device is in landscape mode
  bool get _isLandscape {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {
    // Screen size and device type adaptations
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth <= 350;
    final isIPad = _isIPad;
    final isLandscape = _isLandscape;

    // iPad-specific sizing and layout adjustments
    double containerWidth = isIPad 
      ? (isLandscape 
          ? screenWidth * 0.7  // Wider in landscape
          : screenWidth * 0.9) // Slightly narrower in portrait
      : screenWidth * (332 / 393);

    double containerHeight = isIPad 
      ? (isLandscape 
          ? screenHeight * 0.2  // Shorter in landscape
          : screenHeight * 0.12) // Slightly taller in portrait
      : 72;

    TextStyle dateTextStyle = isIPad 
      ? AppTextStyles.medium18.copyWith(color: AppColor.gray800)
      : (isSmallScreen 
          ? AppTextStyles.medium14.copyWith(color: AppColor.gray800)
          : AppTextStyles.medium16.copyWith(color: AppColor.gray800));

    TextStyle machineTextStyle = isIPad
      ? AppTextStyles.medium12.copyWith(color: AppColor.white100)
      : AppTextStyles.medium10.copyWith(color: AppColor.white100);

    TextStyle cancelButtonTextStyle = isIPad
      ? AppTextStyles.medium16.copyWith(color: AppColor.blue400)
      : (isSmallScreen 
          ? AppTextStyles.semiBold12.copyWith(color: AppColor.blue400)
          : AppTextStyles.semiBold14.copyWith(color: AppColor.blue400));

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: AppColor.white100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: AppColor.gray300,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: isIPad ? 24 : 16, 
          top: isIPad ? 20 : 13
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: isIPad ? 90 : 70,
              height: isIPad ? 20 : 16,
              decoration: BoxDecoration(
                  color: AppColor.blue400,
                  borderRadius: BorderRadius.circular(3)),
              child: Center(
                child: Text(
                  "${widget.machine}",
                  style: machineTextStyle,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: isIPad ? 15 : 10),
                  child: Text(
                    "${widget.resDate} ${widget.dayOfWeek} 예약",
                    style: dateTextStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: isIPad ? 20 : 10, 
                    top: isIPad ? 10 : 5
                  ),
                  child: _cancel == true
                      ? Container(
                          width: isIPad 
                            ? screenWidth * (100 / 393) 
                            : screenWidth * (70 / 393),
                          height: isIPad 
                            ? screenHeight * (36 / 893) 
                            : screenHeight * (26 / 893),
                          decoration: BoxDecoration(
                            color: AppColor.gray200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '취소 완료',
                              style: isIPad
                                ? AppTextStyles.medium16.copyWith(color: AppColor.gray500)
                                : (isSmallScreen
                                    ? AppTextStyles.medium12.copyWith(color: AppColor.gray500)
                                    : AppTextStyles.medium14.copyWith(color: AppColor.gray500)),
                            ),
                          ),
                        )
                      : checkDate(widget.resDate)
                          ? Container(
                          width: isIPad 
                            ? screenWidth * (100 / 393) 
                            : screenWidth * (70 / 393),
                          height: isIPad 
                            ? screenHeight * (36 / 893) 
                            : screenHeight * (26 / 893),
                              decoration: BoxDecoration(
                                color: AppColor.gray200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '사용 완료',
                                  style: isIPad
                                    ? AppTextStyles.medium16.copyWith(color: AppColor.gray500)
                                    : (isSmallScreen
                                        ? AppTextStyles.medium12.copyWith(color: AppColor.gray500)
                                        : AppTextStyles.medium14.copyWith(color: AppColor.gray500)),
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
                          width: isIPad 
                            ? screenWidth * (100 / 393) 
                            : screenWidth * (70 / 393),
                          height: isIPad 
                            ? screenHeight * (36 / 893) 
                            : screenHeight * (26 / 893),
                                decoration: BoxDecoration(
                                  color: AppColor.gray200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '예약 취소',
                                    style: cancelButtonTextStyle,
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