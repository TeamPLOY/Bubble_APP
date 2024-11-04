import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/data/models/reservation_state_model.dart';
import 'package:bubble_app/presentation/pages/alarm/notice_page.dart';
import 'package:bubble_app/presentation/widgets/button/alarm_button.dart';
import 'package:bubble_app/presentation/widgets/box/reservation_cancel_box.dart';
import 'package:bubble_app/data/providers/network/apis/reservation/reservation_state_api.dart';
import 'package:bubble_app/presentation/pages/alarm/alarm_page.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  _ReservationStatePage createState() => _ReservationStatePage();
}

class _ReservationStatePage extends State<ReservationPage> {
  int _selectedButtonIndex = 2;
  List<ReservationStateModel> reservationStateList = [];
  bool isLoading = true; // 로딩 상태 추가

  @override
  void initState() {
    super.initState();
    fetchReservationState();
  }

  void fetchReservationState() async {
    ReservationStateApi reservationStateApi = ReservationStateApi();
    reservationStateList = await reservationStateApi.fetchreservationstate();
    setState(() {
      isLoading = false; // 데이터 로드 완료
    });
  }

  void _handleButtonPress(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    Widget page;
    if (index == 0) {
      page = AlarmPage();
    } else if (index == 1) {
      page = NoticePage();
    } else {
      return; // 인덱스가 0이나 1이 아닐 경우 함수 종료
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page), // 애니메이션 없이 페이지 전환
    );
  }

  String formatDate(String date) {
    return '${date.substring(0, 4)}년 ${date.substring(5, 7)}월 ${date.substring(8, 10)}일';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100,
      body: SafeArea(
        child: Column(
          children: [
            SideHeader(text: "예약 목록"),
            SizedBox(height: 30),
            AlarmButton(
              selectedButtonIndex: _selectedButtonIndex,
              onButtonPressed: _handleButtonPress,
            ),
            SizedBox(height: 46),
            Expanded(
              child: isLoading // 로딩 상태에 따라 UI 변경
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final reservation = reservationStateList[index];
                          return Cancel(
                            cancel: reservation.cancel,
                            resDate: formatDate(reservation.date),
                            roomnumber: reservation.washingRoom,
                            washingRoom: reservation.washingRoom,
                          ); // Cancel 위젯 사용
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 12);
                        },
                        itemCount: reservationStateList.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
