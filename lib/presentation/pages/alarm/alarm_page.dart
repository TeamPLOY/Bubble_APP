import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 날짜 형식 변환을 위한 패키지
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/pages/alarm/notice_page.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/presentation/pages/alarm/reservation_page.dart';
import 'package:bubble_app/presentation/widgets/button/alarm_button.dart';
import 'package:bubble_app/data/providers/network/apis/notice/notice_notice_api.dart';
import 'package:bubble_app/data/models/notification_notification_model.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  int _selectedButtonIndex = 0;
  List<NotificationNotificationModel> noticelist = [];
  Map<String, List<NotificationNotificationModel>> groupedNotices = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getnotice();
  }

  void getnotice() async {
    NoticeNoticeApi notice = NoticeNoticeApi();
    noticelist = await notice.fetnotification();

    // 데이터를 날짜별로 그룹화
    groupedNotices = groupByDate(noticelist);

    setState(() {
      isLoading = false;
    });
  }

  Map<String, List<NotificationNotificationModel>> groupByDate(
      List<NotificationNotificationModel> notices) {
    Map<String, List<NotificationNotificationModel>> grouped = {};
    for (var notice in notices) {
      String formattedDate = formatDate(notice.date); // 날짜 형식 변환
      if (grouped.containsKey(formattedDate)) {
        grouped[formattedDate]!.add(notice);
      } else {
        grouped[formattedDate] = [notice];
      }
    }
    return grouped;
  }

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date); // "2024-11-11" 문자열을 DateTime으로 변환
    return DateFormat('yyyy년 MM월 dd일').format(parsedDate); // 원하는 형식으로 변환
  }

  void _handleButtonPress(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => NoticePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ReservationListPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100,
      body: SafeArea(
        child: isLoading
            ? Center(child: Text('로딩중', style: AppTextStyles.semiBold14))
            : Column(
                children: [
                  SideHeader(text: "알림"),
                  SizedBox(height: 30),
                  AlarmButton(
                    selectedButtonIndex: _selectedButtonIndex,
                    onButtonPressed: _handleButtonPress,
                  ),
                  SizedBox(height: 26),
                  Expanded(
                    child: ListView.builder(
                      itemCount: groupedNotices.keys.length,
                      itemBuilder: (context, index) {
                        String dateKey = groupedNotices.keys.elementAt(index);
                        List<NotificationNotificationModel> notices =
                            groupedNotices[dateKey]!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 날짜 헤더
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  dateKey,
                                  style: AppTextStyles.semiBold14
                                      .copyWith(color: AppColor.gray800),
                                ),
                              ),
                              // 같은 날짜의 알림 리스트
                              ...notices.map((notice) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        (345 / 393),
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColor.white100,
                                      border: Border.all(
                                          color: AppColor.gray300, width: 1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16.0, top: 13),
                                      child: Text(
                                        '${notice.name}님, ${notice.machine}가 완료되었습니다.',
                                        style: AppTextStyles.semiBold14
                                            .copyWith(color: AppColor.gray800),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
