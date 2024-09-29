import 'package:bubble_app/Components/Box/cancel.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/components/Header/header.dart';
import 'package:bubble_app/components/Button/alarm.dart';
import 'package:bubble_app/pages/Alarm_page/Notice_page.dart';
import 'package:bubble_app/pages/Alarm_page/Alarm_page.dart';
import 'package:bubble_app/Utils/reservation_state_get.dart';
import 'package:bubble_app/Models/reservation_state_model.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  int _selectedButtonIndex = 2;
  List<ReservationStateModel> reservationStateList=[];

  @override
  void initState() {
    super.initState();
    reservation_state();
  }

  void reservation_state() async{
    ReservationStateGet reservation = ReservationStateGet();
    reservationStateList= await reservation.fetchreservation();
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
  String todate(String date){
      late String ymd = date.substring(0,4) +
      '년 ' +
      date.substring(5, 7) +
      '월 ' + 
      date.substring(8, 10)+'일';

      return ymd;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(text: "예약 목록"),
            SizedBox(height: 30,),
            AlarmButton(
              selectedButtonIndex: _selectedButtonIndex,
              onButtonPressed: _handleButtonPress,
            ),
            SizedBox(height: 46,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                  itemBuilder: (context, index) {

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                          
                        Cancel(cancel: reservationStateList[index].cancel,resDate: reservationStateList[index].date,date: reservationStateList[index].resDate,roomnumber: reservationStateList[index].washingRoom,washingRoom: reservationStateList[index].washingRoom,),  // 여기에 맞게 Cancel 위젯 사용
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
