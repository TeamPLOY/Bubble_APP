import 'package:flutter/material.dart';
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
  bool isLoading = true; // 초기 로딩 상태

  @override
  void initState() {
    super.initState();
    getnotice();
  }

  void getnotice() async {
    NoticeNoticeApi notice = NoticeNoticeApi();
    noticelist = await notice.fetnotification();
    setState(() {
      isLoading = false; // 데이터 로드 완료 후 상태 변경
    });
  }


  void _handleButtonPress(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    if (index == 1) {
      Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        NoticePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                  ),
                );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100, // AppColor에서 색상 가져오기
      body: SafeArea(
        child: isLoading? Text('로딩중'):Column(
          children: [
            SideHeader(text: "알림"),
            SizedBox(height: 30),
            AlarmButton(
              selectedButtonIndex: _selectedButtonIndex,
              onButtonPressed: _handleButtonPress,
            ),
            SizedBox(height: 26),
            Expanded(
              // Expand로 공간을 확보
              child: ListView.builder(
                itemCount: noticelist.length, // 원하는 알림 개수 설정
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width * (345 / 393),
                        height: 92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.white100,
                          border: Border.all(color: AppColor.gray300, width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 17.0, top: 16),
                              child: Text(
                                '${noticelist[index].name }님, ${noticelist[index].machine}가 완료되었습니다.\n어서 건조기를 돌리세요!',
                                style: AppTextStyles.semiBold14
                                    .copyWith(color: AppColor.gray800),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0, top: 5),
                              child: Text(
                                '${noticelist[index].date}',
                                style: AppTextStyles.medium12
                                    .copyWith(color: AppColor.gray600),
                              ),
                            ),
                          ],
                        ),
                      ),
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
