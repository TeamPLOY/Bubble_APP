import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/data/models/reservation_state_model.dart';
import 'package:bubble_app/presentation/pages/alarm/notice_page.dart';
import 'package:bubble_app/presentation/widgets/button/alarm_button.dart';
import 'package:bubble_app/presentation/widgets/box/reservation_cancel_box.dart';
import 'package:bubble_app/data/providers/network/apis/reservation/reservation_state_api.dart';
import 'package:bubble_app/presentation/pages/alarm/alarm_page.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  _ReservationStatePage createState() => _ReservationStatePage();
}

class _ReservationStatePage extends State<ReservationPage> {
  int _selectedButtonIndex = 2;
  List<ReservationStateModel> reservationStateList = [];

  @override
  void initState() {
    super.initState();
    reservation_state();
  }

  void reservation_state() async {
    ReservationStateApi reservationstate = ReservationStateApi();
    reservationStateList = await reservationstate.fetchreservationstate();
    setState(() {});

    print(reservationStateList.first.date);
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
    } else if (index == 1) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => NoticePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; // 애니메이션 없이 바로 화면 전환
          },
        ),
      );
    }
  }

  String todate(String date) {
    late String ymd = date.substring(0, 4) +
        '년 ' +
        date.substring(5, 7) +
        '월 ' +
        date.substring(8, 10) +
        '일';

    return ymd;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white100,
      body: SafeArea(
        child: Column(
          children: [
            SideHeader(text: "예약 목록"),
            SizedBox(
              height: 30,
            ),
            AlarmButton(
              selectedButtonIndex: _selectedButtonIndex,
              onButtonPressed: _handleButtonPress,
            ),
            SizedBox(
              height: 46,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Cancel(
                          cancel: reservationStateList[index].cancel,
                          resDate: reservationStateList[index].date,
                          roomnumber: reservationStateList[index].washingRoom,
                          washingRoom: reservationStateList[index].washingRoom,
                        ), // 여기에 맞게 Cancel 위젯 사용
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12);
                  },
                  itemCount: reservationStateList.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
