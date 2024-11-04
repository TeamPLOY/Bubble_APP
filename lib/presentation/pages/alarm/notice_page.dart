import 'package:flutter/material.dart';
import 'package:bubble_app/data/providers/network/apis/notice/notice_api.dart';
import 'package:bubble_app/presentation/pages/reservation/reservation_page.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/presentation/widgets/button/alarm_button.dart';
import 'package:bubble_app/presentation/widgets/box/notice_box.dart';
import 'package:bubble_app/data/models/notice_model.dart';
import 'package:bubble_app/presentation/pages/alarm/alarm_page.dart';
import 'package:bubble_app/presentation/pages/alarm/notice_detail_page.dart';
import 'package:bubble_app/theme.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  int _selectedButtonIndex = 1;
  late List<Noticemodel> noticelist = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getnotice();
  }

  void getnotice() async {
    NoticeApi notice = NoticeApi();
    noticelist = await notice.fetchNotice();
    setState(() {});
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
          pageBuilder: (context, animation, secondaryAnimation) =>
              ReservationPage(),
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
        pageBuilder: (context, animation, secondaryAnimation) =>
            NoticeDetailPage(
          items: indexs,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // 애니메이션 없이 바로 화면 전환
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white100,
      body: SafeArea(
        child: Column(
          children: [
            SideHeader(text: "공지사항"),
            SizedBox(height: 30),
            AlarmButton(
              selectedButtonIndex: _selectedButtonIndex,
              onButtonPressed: _handleButtonPress,
            ),
            SizedBox(height: 46),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: () {
                        _onItemTap(index);
                      }, // 공지사항 클릭 시 로딩 후 페이지 이동
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
