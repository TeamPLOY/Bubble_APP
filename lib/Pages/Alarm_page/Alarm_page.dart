import 'package:bubble_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/Pages/Alarm_page/Notice_page.dart';
import 'package:bubble_app/Pages/Alarm_page/Reservation.dart';
import 'package:bubble_app/Components/Header/header.dart';
import 'package:bubble_app/Components/Button/Alarm.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  int _selectedButtonIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(text: "알림"),
            SizedBox(
              height: 30,
            ),
            AlarmButton(
              selectedButtonIndex: _selectedButtonIndex,
              onButtonPressed: _handleButtonPress,
            ),
            SizedBox(height: 26,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2024년 09월 30일',style: medium14.copyWith(color: gray800),),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width*(345/393),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: white100,
                    border: Border.all(color: gray300,width: 1)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left:16.0,top: 10,right: 8),
                    child: Text('한태영님, 세탁기가 완료되었습니다. 어서 건조기를 돌리세요!',style: medium12.copyWith(color: gray800),),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width*(345/393),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: white100,
                    border: Border.all(color: gray300,width: 1)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left:16.0,top: 10,right: 8),
                    child: Text('한태영님, 세탁기가 완료되었습니다. 어서 건조기를 돌리세요!',style: medium12.copyWith(color: gray800),),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width*(345/393),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: white100,
                    border: Border.all(color: gray300,width: 1)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left:16.0,top: 10,right: 8),
                    child: Text('한태영님, 세탁기가 완료되었습니다. 어서 건조기를 돌리세요!',style: medium12.copyWith(color: gray800),),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width*(345/393),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: white100,
                    border: Border.all(color: gray300,width: 1)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left:16.0,top: 10,right: 8),
                    child: Text('한태영님, 세탁기가 완료되었습니다. 어서 건조기를 돌리세요!',style: medium12.copyWith(color: gray800),),
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
