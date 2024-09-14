import 'package:bubble_app/Components/Button/reservationButton.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Components/Box/check_box.dart';
import 'package:bubble_app/Components/Header/header.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  void _onStateChanged(int boxState) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Blue box should be first in the stack
            Container(
              width: MediaQuery.of(context).size.width,
              height: 320,
              decoration: BoxDecoration(
                color: blue400,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Header(text: "예약"),
            ),
            Positioned(
              top: 120,
              left: 20,
              right: 20,
              child: Image.asset(
                'assets/img/sun.png',
                width: 20,
                height: 20,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * (345 / 393),
                height: 500,
                decoration: BoxDecoration(
                  color: white100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.only(left: 23, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "세탁실을 이용할 날짜 선택해주세요",
                      style: semiBold18.copyWith(color: gray800),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "하나만 선택해주세요",
                      style: medium12.copyWith(color: gray500),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        CheckBox(
                            week: "화", day: 5, onStateChanged: _onStateChanged),
                        SizedBox(width: 19), // Space between checkboxes
                        CheckBox(
                            week: "목", day: 7, onStateChanged: _onStateChanged),
                      ],
                    ),
                    SizedBox(height: 150),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "빨간색은 선택이 불가능합니다.",
                            style: medium12.copyWith(color: red100),
                          ),
                          SizedBox(height: 14),
                          Reservationbutton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
