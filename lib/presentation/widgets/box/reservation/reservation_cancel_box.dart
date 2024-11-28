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
    DateTime onlyParsedDate =
        DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

    if (onlyParsedDate == onlyToday) {
      return false;
    } else if (onlyParsedDate.isBefore(onlyToday)) {
      return true;
    } else if (onlyParsedDate.isAfter(onlyToday)) {
      return false;
    }

    throw Exception("Invalid date format");
  }

  // Determine device type and size
  DeviceType _getDeviceType(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final double longgestSide = MediaQuery.of(context).size.longestSide;

    if (shortestSide < 600) {
      return DeviceType.phone;
    } else if (shortestSide >= 600 && shortestSide < 1024) {
      return DeviceType.iPad;
    } else {
      // Consider 13-inch iPad or similar large tablet
      return DeviceType.largeTablet;
    }
  }

  // Check if device is in landscape mode
  bool _isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {
    // Determine device characteristics
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceType = _getDeviceType(context);
    final isLandscape = _isLandscape(context);
    final isSmallScreen = screenWidth <= 350;

<<<<<<< HEAD
    // iPad-specific sizing and layout adjustments
    double containerWidth = isIPad
        ? (isLandscape
            ? screenWidth * 0.7 // Wider in landscape
            : screenWidth * 0.9) // Slightly narrower in portrait
        : screenWidth * (332 / 393);

    double containerHeight = isIPad
        ? (isLandscape
            ? screenHeight * 0.2 // Shorter in landscape
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
=======
    // Responsive sizing and styling
    double containerWidth = deviceType == DeviceType.phone 
      ? screenWidth * (332 / 393)
      : deviceType == DeviceType.iPad 
        ? (isLandscape ? screenWidth * 0.7 : screenWidth * 0.9)
        : screenWidth * 0.95; // Large tablet takes almost full width

    double containerHeight = deviceType == DeviceType.phone 
      ? 72
      : deviceType == DeviceType.iPad 
        ? (isLandscape ? screenHeight * 0.2 : screenHeight * 0.12)
        : screenHeight * 0.15; // Slightly taller for large tablet

    TextStyle dateTextStyle = deviceType == DeviceType.phone
      ? (isSmallScreen 
          ? AppTextStyles.medium14.copyWith(color: AppColor.gray800)
          : AppTextStyles.medium16.copyWith(color: AppColor.gray800))
      : deviceType == DeviceType.iPad
        ? AppTextStyles.medium18.copyWith(color: AppColor.gray800)
        : AppTextStyles.medium20.copyWith(color: AppColor.gray800); // Larger for big tablet

    TextStyle machineTextStyle = deviceType == DeviceType.phone
      ? AppTextStyles.medium10.copyWith(color: AppColor.white100)
      : deviceType == DeviceType.iPad
        ? AppTextStyles.medium12.copyWith(color: AppColor.white100)
        : AppTextStyles.medium14.copyWith(color: AppColor.white100); // Larger for big tablet

    TextStyle cancelButtonTextStyle = deviceType == DeviceType.phone
      ? (isSmallScreen 
          ? AppTextStyles.semiBold12.copyWith(color: AppColor.blue400)
          : AppTextStyles.semiBold14.copyWith(color: AppColor.blue400))
      : deviceType == DeviceType.iPad
        ? AppTextStyles.medium16.copyWith(color: AppColor.blue400)
        : AppTextStyles.medium18.copyWith(color: AppColor.blue400); // Larger for big tablet
>>>>>>> a6ec6e384f6affe6240b2f677a3f299cab901c5d

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
<<<<<<< HEAD
        padding: EdgeInsets.only(left: isIPad ? 24 : 16, top: isIPad ? 20 : 13),
=======
        padding: EdgeInsets.only(
          left: deviceType == DeviceType.phone ? 16 : 
                 deviceType == DeviceType.iPad ? 24 : 32, 
          top: deviceType == DeviceType.phone ? 13 : 
                deviceType == DeviceType.iPad ? 20 : 25
        ),
>>>>>>> a6ec6e384f6affe6240b2f677a3f299cab901c5d
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: deviceType == DeviceType.phone 
                ? 70 
                : deviceType == DeviceType.iPad 
                  ? 90 
                  : 110, // Larger for big tablet
              height: deviceType == DeviceType.phone 
                ? 16 
                : deviceType == DeviceType.iPad 
                  ? 20 
                  : 25, // Larger for big tablet
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
                  padding: EdgeInsets.only(
                    top: deviceType == DeviceType.phone 
                      ? 10 
                      : deviceType == DeviceType.iPad 
                        ? 15 
                        : 20
                  ),
                  child: Text(
                    "${widget.resDate} ${widget.dayOfWeek} 예약",
                    style: dateTextStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
<<<<<<< HEAD
                      right: isIPad ? 20 : 10, top: isIPad ? 10 : 5),
                  child: _cancel == true
                      ? Container(
                          width: isIPad
                              ? screenWidth * (100 / 393)
                              : screenWidth * (70 / 393),
                          height: isIPad
                              ? screenHeight * (36 / 893)
                              : screenHeight * (26 / 893),
=======
                    right: deviceType == DeviceType.phone 
                      ? 10 
                      : deviceType == DeviceType.iPad 
                        ? 20 
                        : 30,
                    top: deviceType == DeviceType.phone 
                      ? 5 
                      : deviceType == DeviceType.iPad 
                        ? 10 
                        : 15
                  ),
                  child: _cancel == true
                      ? Container(
                          width: deviceType == DeviceType.phone 
                            ? screenWidth * (70 / 393) 
                            : deviceType == DeviceType.iPad 
                              ? screenWidth * (100 / 393)
                              : screenWidth * (120 / 393), // Larger for big tablet
                          height: deviceType == DeviceType.phone 
                            ? screenHeight * (26 / 893) 
                            : deviceType == DeviceType.iPad 
                              ? screenHeight * (36 / 893)
                              : screenHeight * (46 / 893), // Larger for big tablet
>>>>>>> a6ec6e384f6affe6240b2f677a3f299cab901c5d
                          decoration: BoxDecoration(
                            color: AppColor.gray200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '취소 완료',
<<<<<<< HEAD
                              style: isIPad
                                  ? AppTextStyles.medium16
                                      .copyWith(color: AppColor.gray500)
                                  : (isSmallScreen
                                      ? AppTextStyles.medium12
                                          .copyWith(color: AppColor.gray500)
                                      : AppTextStyles.medium14
                                          .copyWith(color: AppColor.gray500)),
=======
                              style: deviceType == DeviceType.phone
                                ? (isSmallScreen
                                    ? AppTextStyles.medium12.copyWith(color: AppColor.gray500)
                                    : AppTextStyles.medium14.copyWith(color: AppColor.gray500))
                                : deviceType == DeviceType.iPad
                                  ? AppTextStyles.medium16.copyWith(color: AppColor.gray500)
                                  : AppTextStyles.medium18.copyWith(color: AppColor.gray500), // Larger for big tablet
>>>>>>> a6ec6e384f6affe6240b2f677a3f299cab901c5d
                            ),
                          ),
                        )
                      : checkDate(widget.resDate)
                          ? Container(
<<<<<<< HEAD
                              width: isIPad
                                  ? screenWidth * (100 / 393)
                                  : screenWidth * (70 / 393),
                              height: isIPad
                                  ? screenHeight * (36 / 893)
                                  : screenHeight * (26 / 893),
=======
                          width: deviceType == DeviceType.phone 
                            ? screenWidth * (70 / 393) 
                            : deviceType == DeviceType.iPad 
                              ? screenWidth * (100 / 393)
                              : screenWidth * (120 / 393), // Larger for big tablet
                          height: deviceType == DeviceType.phone 
                            ? screenHeight * (26 / 893) 
                            : deviceType == DeviceType.iPad 
                              ? screenHeight * (36 / 893)
                              : screenHeight * (46 / 893), // Larger for big tablet
>>>>>>> a6ec6e384f6affe6240b2f677a3f299cab901c5d
                              decoration: BoxDecoration(
                                color: AppColor.gray200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '사용 완료',
<<<<<<< HEAD
                                  style: isIPad
                                      ? AppTextStyles.medium16
                                          .copyWith(color: AppColor.gray500)
                                      : (isSmallScreen
                                          ? AppTextStyles.medium12
                                              .copyWith(color: AppColor.gray500)
                                          : AppTextStyles.medium14.copyWith(
                                              color: AppColor.gray500)),
=======
                                  style: deviceType == DeviceType.phone
                                    ? (isSmallScreen
                                        ? AppTextStyles.medium12.copyWith(color: AppColor.gray500)
                                        : AppTextStyles.medium14.copyWith(color: AppColor.gray500))
                                    : deviceType == DeviceType.iPad
                                      ? AppTextStyles.medium16.copyWith(color: AppColor.gray500)
                                      : AppTextStyles.medium18.copyWith(color: AppColor.gray500), // Larger for big tablet
>>>>>>> a6ec6e384f6affe6240b2f677a3f299cab901c5d
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
                                        machine: widget.machine);
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
<<<<<<< HEAD
                                width: isIPad
                                    ? screenWidth * (100 / 393)
                                    : screenWidth * (70 / 393),
                                height: isIPad
                                    ? screenHeight * (36 / 893)
                                    : screenHeight * (26 / 893),
=======
                          width: deviceType == DeviceType.phone 
                            ? screenWidth * (70 / 393) 
                            : deviceType == DeviceType.iPad 
                              ? screenWidth * (100 / 393)
                              : screenWidth * (120 / 393), // Larger for big tablet
                          height: deviceType == DeviceType.phone 
                            ? screenHeight * (26 / 893) 
                            : deviceType == DeviceType.iPad 
                              ? screenHeight * (36 / 893)
                              : screenHeight * (46 / 893), // Larger for big tablet
>>>>>>> a6ec6e384f6affe6240b2f677a3f299cab901c5d
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
<<<<<<< HEAD
=======

// Enum to categorize device types
enum DeviceType {
  phone,
  iPad,
  largeTablet
}
>>>>>>> a6ec6e384f6affe6240b2f677a3f299cab901c5d
