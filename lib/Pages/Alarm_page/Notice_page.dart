import 'package:flutter/material.dart';
import 'package:bubble_app/components/Header/header.dart';
import 'package:bubble_app/components/Button/alarm.dart';
import 'package:bubble_app/pages/Alarm_page/Alarm_page.dart';
import 'package:bubble_app/pages/Alarm_page/Reservation.dart';
import 'package:bubble_app/Components/Box/annoument_box.dart';
import 'package:bubble_app/Utils/notification.dart';
import 'package:bubble_app/Models/notificationmodels.dart';
import 'package:bubble_app/Pages/Alarm_page/notification_detail.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  _NoticePageState createState() => _NoticePageState();
}
class _NoticePageState extends State<NoticePage> {
  int _selectedButtonIndex = 1;
  late List<Notificationmodels> notifilist = [];
  bool isLoading = false; // 로딩 상태를 위한 변수 추가

  @override
  void initState() {
    super.initState();
    getnotifi();
  }

  void getnotifi() async {
    Notifications notification = Notifications();
    notifilist = await notification.fetchNotification();
    setState(() {}); // 데이터를 가져온 후 상태 업데이트
  }

  void _handleButtonPress(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => AlarmPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; // 애니메이션 없이 바로 화면 전환
          },
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Reservation(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; // 애니메이션 없이 바로 화면 전환
          },
        ),
      );
    }
  }
  
  // 공지사항 클릭 시 로딩 상태를 처리한 후 페이지 전환
  void _onItemTap(int indexs) async {
    setState(() {
      isLoading = true; // 로딩 시작
    });

    await Future.delayed(Duration(seconds: 1)); // 페이지 이동 전 임의로 지연 추가

    setState(() {
      isLoading = false; // 로딩 완료
    });

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => NotificationDetail(items: indexs,),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // 애니메이션 없이 바로 화면 전환
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(text: "공지사항"),
            SizedBox(height: 30),
            AlarmButton(
              selectedButtonIndex: _selectedButtonIndex,
              onButtonPressed: _handleButtonPress,
            ),
            SizedBox(height: 46),
            Expanded(
              child:ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: GestureDetector(
                            onTap: (){_onItemTap(index);}, // 공지사항 클릭 시 로딩 후 페이지 이동
                            child: AnnoumentBox(
                              date: notifilist[index].date,
                              text: notifilist[index].title,
                            ),
                          ), 
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16);
                      },
                      itemCount: notifilist.length,
                    ),
            ),
            
          ],
        ),
      ),
    );
  }
}
