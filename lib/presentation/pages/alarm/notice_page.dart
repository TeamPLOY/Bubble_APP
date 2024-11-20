import 'package:bubble_app/presentation/pages/alarm/reservation_page.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/data/providers/network/apis/notice/notice_api.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/presentation/widgets/button/alarm_button.dart';
import 'package:bubble_app/presentation/widgets/box/notice_box.dart';
import 'package:bubble_app/data/models/notice_model.dart';
import 'package:bubble_app/presentation/pages/alarm/alarm_page.dart';
import 'package:bubble_app/presentation/pages/alarm/notice_detail_page.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  int _selectedButtonIndex = 1;
  List<Noticemodel> noticelist = [];
  bool isLoading = true; // 초기 로딩 상태

  @override
  void initState() {
    super.initState();
    getnotice();
  }

  void getnotice() async {
    NoticeApi notice = NoticeApi();
    noticelist = await notice.fetchNotice();
    setState(() {
      isLoading = false; // 데이터 로드 완료 후 상태 변경
    });
  }

  void _handleButtonPress(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    if (index == 0) {
      Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AlarmPage(),
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

  // 공지사항 클릭 시 페이지 전환
  void _onItemTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoticeDetailPage(items: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100,
      body: SafeArea(
        child: Column(
          children: [
            SideHeader(text: "공지사항"),
            SizedBox(height: 30),
            AlarmButton(
              selectedButtonIndex: _selectedButtonIndex,
              onButtonPressed: _handleButtonPress,
            ),
            SizedBox(height: 16),
            Expanded(
              child: isLoading // 로딩 상태에 따라 UI 변경
                  ? Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: GestureDetector(
                            onTap: () => _onItemTap(index), // 공지사항 클릭 시 페이지 이동
                            child: NoticeBox(
                              date: noticelist[index].date,
                              text: noticelist[index].title,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16);
                      },
                      itemCount: noticelist.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
