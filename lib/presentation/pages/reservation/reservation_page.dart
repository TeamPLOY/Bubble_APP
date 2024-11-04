import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bubble_app/presentation/widgets/button/next_button.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/presentation/widgets/box/reservation_box.dart';
import 'package:bubble_app/data/models/reservation_model.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/providers/network/apis/reservation/reservation_get_api.dart';
import 'package:bubble_app/presentation/widgets/modal/reservation_check_modal.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  var access_token = globalTokens?.access_token;
  String ReservationDay = '';
  int? selectedBoxIndex;
  late DateTime now;
  late Timer _timer;
  late Future<List<ReservationModel>> futureReservationData;
  final ReservationGetApi reservationGet = ReservationGetApi();
  String serverResponse = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    futureReservationData = reservationGet.fetchData();

    _timer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      DateTime currentTime = DateTime.now();
      if (currentTime.weekday == DateTime.sunday &&
          currentTime.hour == 10 &&
          currentTime.minute == 0) {
        setState(() {
          futureReservationData = reservationGet.fetchData();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showReservationCancleModal() {
    if (selectedBoxIndex == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ReservationCheckModal(
            date: ReservationDay,
            onConfirm: () async {
              await sendReservation();
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
      'Authorization': 'Bearer ${access_token}'
    };
    final body = jsonEncode({
      'date': ReservationDay,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onStateChanged(int index, bool isSelected) {
    setState(() {
      selectedBoxIndex = isSelected ? index : null;

      if (isSelected) {
        futureReservationData.then((reservations) {
          ReservationDay = reservations[index].date;
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
              child: SideHeader(text: "예약"),
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
                child: FutureBuilder<List<ReservationModel>>(
                  future: futureReservationData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('오류: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<ReservationModel> reservations = snapshot.data!;

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
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width >= 700
                                      ? 3.5
                                      : MediaQuery.of(context).size.width >= 400
                                          ? 2.5
                                          : 1.3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: reservations.length,
                            itemBuilder: (context, index) {
                              ReservationModel reservation =
                                  reservations[index];
                              return GestureDetector(
                                onTap: () {
                                  _onStateChanged(index, true);
                                },
                                child: ReservationBox(
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
                              height: MediaQuery.of(context).size.height *
                                  (45 / 835)),
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
                                  child: NextButton(
                                    text: "예약하기",
                                    onPressed: _showReservationCancleModal,
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
