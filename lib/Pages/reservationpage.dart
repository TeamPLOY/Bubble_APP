import 'package:flutter/material.dart';
import 'package:bubble_app/Models/check_model.dart';
import 'package:bubble_app/Utils/check_get.dart';
import 'package:bubble_app/Components/Button/reservationButton.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Components/Box/check_box.dart';
import 'package:bubble_app/Components/Header/header.dart';
import 'package:bubble_app/Components/Modal/check_modal.dart';
import 'package:bubble_app/Utils/reservation_get.dart';
import 'dart:async';
import 'package:bubble_app/Models/reservation_models.dart';
import 'package:bubble_app/Utils/reservation_post.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  late String ReservationDay = '';
  int? selectedBoxIndex;
  late DateTime now;
  late Future<bool?> futureCheckData;
  final CheckGet checkGet = CheckGet();
  late Future<List<Reservation>> futureReservationData;
  final ReservationGet reservationGet = ReservationGet();
  String serverResponse = '';
  bool hasReservation = false; // 추가된 필드

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    futureCheckData = checkGet.fetchData().then((value) {
      setState(() {
        hasReservation = value ?? false;
      });
    });
    futureReservationData = reservationGet.fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showCheckModal() {
    if (selectedBoxIndex == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: CheckModal(
            date: ReservationDay,
            onConfirm: () async {
              print('예약 요청');
              ReservationPost reservationPost =
                  ReservationPost(date: DateTime.parse(ReservationDay));
              await reservationPost.reservationDate();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void _onStateChanged(int index, bool isSelected) {
    setState(() {
      selectedBoxIndex = isSelected ? index : null;

      if (isSelected) {
        futureReservationData.then((reservations) {
          ReservationDay = reservations[index].date;
          print(ReservationDay);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white100,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: blue400,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                height: 320,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width * (350 / 393),
                  height: 480,
                  decoration: BoxDecoration(
                    color: white100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 23, top: 30, right: 23),
                  child: FutureBuilder<List<Reservation>>(
                    future: futureReservationData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('오류: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        List<Reservation> reservations = snapshot.data!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "세탁실을 이용할 날짜 선택해주세요",
                              style: semiBold18.copyWith(color: gray800),
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height -
                                      MediaQuery.of(context).padding.top) *
                                  0.006,
                            ),
                            Text(
                              "하나만 선택해주세요",
                              style: medium12.copyWith(color: gray500),
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height -
                                      MediaQuery.of(context).padding.top) *
                                  0.025,
                            ),
                            GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.3,
                                mainAxisSpacing: 19,
                                crossAxisSpacing: 19,
                              ),
                              itemCount: reservations.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Reservation reservation = reservations[index];
                                return GestureDetector(
                                  onTap: () {
                                    _onStateChanged(index, true);
                                  },
                                  child: CheckBox(
                                    onStateChanged: (isSelected) {
                                      _onStateChanged(index, isSelected);
                                    },
                                    today: DateTime.parse(reservation.date),
                                    userCount: reservation.userCount,
                                    isSelected: selectedBoxIndex == index,
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height -
                                      MediaQuery.of(context).padding.top) *
                                  0.05,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    hasReservation
                                        ? "예약이 있습니다."
                                        : "빨간색은 선택이 불가능합니다.",
                                    style: medium12.copyWith(color: red100),
                                  ),
                                  SizedBox(
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                MediaQuery.of(context)
                                                    .padding
                                                    .top) *
                                            0.005,
                                  ),
                                  Center(
                                    child: Reservationbutton(
                                      onPressed: _showCheckModal,
                                    ),
                                  ),
                                  if (serverResponse.isNotEmpty)
                                    Text(
                                      serverResponse,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(child: Text('예약 데이터가 없습니다.'));
                      }
                    },
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
                top: 60,
                left: 20,
                right: 20,
                child: Image.asset(
                  'assets/img/sun.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
