import 'package:bubble_app/data/providers/network/apis/profile/profile_api.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'dart:async';
import 'package:bubble_app/presentation/widgets/button/next_button.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/presentation/widgets/box/reservation_box.dart';
import 'package:bubble_app/data/models/reservation_model.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/providers/network/apis/reservation/reservation_get_api.dart';
import 'package:bubble_app/data/providers/network/apis/reservation/reservation_post_api.dart';
import 'package:bubble_app/presentation/widgets/modal/reservation_check_modal.dart';
import 'package:bubble_app/data/models/user_model.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  var access_token = globalTokens?.access_token;
  String reservationDay = '';
  int? selectedBoxIndex;
  late DateTime now;
  late Timer _timer;
  late Future<List<ReservationModel>> futureReservationData;
  final ReservationGetApi reservationGet = ReservationGetApi();
  String serverResponse = '';
  bool isLoading = false;
  late bool isfirstclass;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    getuserstaet();
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

  void _showReservationCancelModal() {
    if (selectedBoxIndex == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ReservationCheckModal(
            date: reservationDay,
            onConfirm: () async {
              await sendReservation();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
  Future<void> getuserstaet() async {
    var access_token = globalTokens?.access_token;
    ProfileApi get_profile = ProfileApi(access_token: access_token);
    UserModel user= await get_profile.fetchData();
    if(user.studentNum/1000-user.studentNum%1000/1000==1.0){
      isfirstclass= true;
    }
    else{
      isfirstclass= false;
    }
  }
  
  Future<void> sendReservation() async {
    if (reservationDay.isEmpty) {
      setState(() {
        serverResponse = '날짜를 선택해주세요.';
      });
      return;
    }

    setState(() {
      isLoading = true;
    });
    print(reservationDay);
    ReservationPostApi postApi = ReservationPostApi(date:reservationDay );
    postApi.reservationDate();
}

  void _onStateChanged(int index, bool isSelected) {
    setState(() {
      selectedBoxIndex = isSelected ? index : null;

      if (isSelected) {
        futureReservationData.then((reservations) {
          reservationDay = reservations[index].date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white100,
        body:Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 320,  
              decoration: BoxDecoration(
                color: AppColor.blue400, // AppColor 사용
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
                  color: AppColor.white100, // AppColor 사용
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
        
                      return ListView(
                        children:[ Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "세탁실을 이용할 날짜 선택해주세요",
                              style: AppTextStyles.semiBold18.copyWith(
                                  color: AppColor.gray800), // AppTextStyles 사용
                            ),
                            SizedBox(height: 6),
                            Text(
                              "하나만 선택해주세요",
                              style: AppTextStyles.medium12.copyWith(
                                  color: AppColor.gray500), // AppTextStyles 사용
                            ),
                            SizedBox(height: 30),
                            GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:1.3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: reservations.length,
                              itemBuilder: (context, index) {
                                ReservationModel reservation =
                                    reservations[index];
                                return GestureDetector(
                                  onTap: () {
                                   isfirstclass!=null&&isfirstclass==false? _onStateChanged(index, true):(){};
                                  },
                                  child: FutureBuilder<bool>(
                                    future: Future.value(isfirstclass), // isfirstclass 값을 Future로 감싸서 반환
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator()); // 로딩 중
                                      } else if (snapshot.hasData) {
                                        return ReservationBox(
                                          isfirstclass: snapshot.data ?? false, // 데이터가 있으면 사용
                                          onStateChanged: (isSelected) {
                                            _onStateChanged(index, isSelected);
                                          },
                                          today: DateTime.parse(reservation.date),
                                          userCount: reservation.userCount,
                                          isSelected: selectedBoxIndex == index,
                                        );
                                      } else {
                                        return Center(child: Text('데이터를 불러오는 중 오류가 발생했습니다.'));
                                      }
                                    },
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
                                    style: AppTextStyles.medium12.copyWith(
                                        color:
                                            AppColor.red100), // AppTextStyles 사용
                                  ),
                                  SizedBox(height: 14),
                                  Center(
                                    child: GestureDetector(
                                      onTap: (){
                                
                                         _showReservationCancelModal();
                                      },
                                      child: NextButton(
                                        text: "예약하기",
                                        onPressed:(){}
                                      ),
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
                                    SizedBox(height: 30,)
                                ],
                              ),
                            ),
                          ],
                        ),]
                      );
                    } else {
                      return Center(child: Text('예약 데이터가 없습니다.'));
                    }
                  },
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
