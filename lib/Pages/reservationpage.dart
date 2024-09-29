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
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  late String ReservationDay = '';
  int? selectedBoxIndex;
  late DateTime now;
  late Timer _timer;
  late Future<CheckGetModel> futureCheckData;
  final CheckGet checkGet = CheckGet();
  late Future<List<Reservation>> futureReservationData;
  final ReservationGet reservationGet = ReservationGet();
  String serverResponse = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();

    futureCheckData = checkGet.fetchData();
    futureReservationData = reservationGet.fetchData();

    _timer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      DateTime currentTime = DateTime.now();
      if (currentTime.weekday == DateTime.sunday &&
          currentTime.hour == 10 &&
          currentTime.minute == 0) {
        setState(() {
          futureCheckData = checkGet.fetchData();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
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
              print('예약 요청 중...'); // 로그 추가
              await sendReservation(); // 서버 요청 함수 호출
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  Future<void> sendReservation() async {
    if (ReservationDay.isEmpty) {
      setState(() {
        serverResponse = '날짜를 선택해주세요.';
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('https://your-server-url.com/reservations');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your-token-here'
    };
    final body = jsonEncode({
      'date': ReservationDay,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('서버 응답 받음: ${response.statusCode}'); // 로그 추가

      if (response.statusCode == 200) {
        setState(() {
          serverResponse = '예약이 성공적으로 완료되었습니다.';
        });
      } else {
        setState(() {
          serverResponse = '예약에 실패했습니다. 다시 시도해주세요.';
        });
      }
    } catch (error) {
      setState(() {
        serverResponse = '서버 오류가 발생했습니다: $error';
      });
      print('에러 발생: $error'); // 로그 추가
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onStateChanged(int index, bool isSelected) {
    setState(() {
      selectedBoxIndex = isSelected ? index : null;

      if (isSelected && futureReservationData != null) {
        futureReservationData.then((reservations) {
          ReservationDay = reservations[index].date; // 선택된 날짜 저장
          print(ReservationDay);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
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
              top: 60,
              left: 20,
              right: 20,
              child: Image.asset(
                'assets/img/sun.png',
                width: 200,
                height: 200,
              ),
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
                          SizedBox(height: 6),
                          Text(
                            "하나만 선택해주세요",
                            style: medium12.copyWith(color: gray500),
                          ),
                          SizedBox(height: 30),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: reservations.length,
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
                          ),
                          SizedBox(height: 45),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "빨간색은 선택이 불가능합니다.",
                                  style: medium12.copyWith(color: red100),
                                ),
                                SizedBox(height: 14),
                                Center(
                                  child: Reservationbutton(
                                    onPressed: _showCheckModal,
                                  ),
                                ),
                                if (serverResponse.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      serverResponse,
                                      style: TextStyle(color: Colors.red),
                                    ),
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
          ],
        ),
      ),
    );
  }
}
