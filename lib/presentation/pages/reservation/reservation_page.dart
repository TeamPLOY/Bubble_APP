import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/presentation/widgets/box/reservation/reservation_weekbox.dart';
import 'package:bubble_app/presentation/widgets/box/reservation/reservation_machinebox.dart';
import 'package:bubble_app/data/providers/network/apis/reservation/reservation_get_api.dart';
import 'package:bubble_app/data/providers/network/apis/reservation/reservation_post_api.dart';
import 'package:bubble_app/presentation/widgets/modal/reservation_check_modal.dart';
import 'package:bubble_app/data/providers/network/apis/profile/profile_api.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/presentation/pages/reservation/finish_page.dart';
import 'package:bubble_app/presentation/widgets/button/next_button.dart';
import 'package:bubble_app/data/models/reservation_model.dart';
import 'package:bubble_app/data/models/user_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  late Future<List<ReservationModel>> reservationsFuture;
  late UserModel user_profile;
  bool isReservationed = false;
  int selectedIndex = 4;
  int selectedMachine = -1;
  var access_token = globalTokens?.access_token ?? '';
  bool showImage = false; // 이미지 표시 여부를 위한 상태 변수
  late Future<UserModel> userFuture;

  @override
  void initState() {
    super.initState();

    reservationsFuture = fetchReservations();
  }

  Future<List<ReservationModel>> fetchReservations() async {
    await fetchUser();
    final reservationGetApi = ReservationGetApi();
    return await reservationGetApi.fetchData();
  }

  Future<void> fetchUser() async {
    final userGetapi = ProfileApi(access_token: access_token);
    user_profile = await userGetapi.fetchData();
  }

  int parseNumberFromString(String input) {
    RegExp regExp = RegExp(r'\d+');
    String? numberStr = regExp.firstMatch(input)?.group(0);

    if (numberStr != null) {
      return int.parse(numberStr);
    } else {
      throw FormatException("숫자가 포함된 문자열이 아닙니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100,
      body: SafeArea(
        child: FutureBuilder<List<ReservationModel>>(
          future: reservationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              List<ReservationModel> reservations = snapshot.data!;
              ReservationModel addReservation = ReservationModel(
                  date: reservations.first.date,
                  day: reservations.first.day,
                  userCount: [false, false, false, false]);
              reservations.add(addReservation);
              return ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideHeader(text: "예약"),
                      const SizedBox(height: 24),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '세탁실을 이용할 날짜와\n기기를 선택하세요!',
                                    style: AppTextStyles.semiBold24
                                        .copyWith(color: AppColor.gray800),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '1가지만 선택이 가능해요.',
                                    style: AppTextStyles.medium16
                                        .copyWith(color: AppColor.blue400),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    '희망하는 날짜 선택',
                                    style: AppTextStyles.semiBold18
                                        .copyWith(color: AppColor.gray800),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      ReservationWeekbox(
                                        machine_state: parseNumberFromString(
                                                    user_profile.roomNum) >=
                                                424 &&
                                            parseNumberFromString(
                                                    user_profile.roomNum) <=
                                                434,
                                        day: reservations[0].date,
                                        week: "월",
                                        isActive: selectedIndex == 0,
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 0;
                                            selectedMachine = -1;
                                            isReservationed = false;
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                      ReservationWeekbox(
                                        machine_state: parseNumberFromString(
                                                    user_profile.roomNum) >=
                                                418 &&
                                            parseNumberFromString(
                                                    user_profile.roomNum) <=
                                                423,
                                        day: reservations[1].date,
                                        week: "화",
                                        isActive: selectedIndex == 1,
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 1;
                                            selectedMachine = -1;
                                            isReservationed = false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      ReservationWeekbox(
                                        machine_state: parseNumberFromString(
                                                    user_profile.roomNum) >=
                                                424 &&
                                            parseNumberFromString(
                                                    user_profile.roomNum) <=
                                                434,
                                        day: reservations[2].date,
                                        week: "수",
                                        isActive: selectedIndex == 2,
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 2;
                                            selectedMachine = -1;
                                            isReservationed = false;
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                      ReservationWeekbox(
                                        machine_state: parseNumberFromString(
                                                    user_profile.roomNum) >=
                                                418 &&
                                            parseNumberFromString(
                                                    user_profile.roomNum) <=
                                                423,
                                        day: reservations[3].date,
                                        week: "목",
                                        isActive: selectedIndex == 3,
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 3;
                                            selectedMachine = -1;
                                            isReservationed = false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        (40 / 852),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '희망하는 세탁기 선택',
                                        style: AppTextStyles.semiBold18
                                            .copyWith(color: AppColor.gray800),
                                      ),
                                      const SizedBox(width: 8),
                                      GestureDetector(
                                        onTapDown: (_) {
                                          // 터치 시작 시 이미지 표시
                                          setState(() {
                                            showImage = true;
                                          });
                                        },
                                        onTapUp: (_) {
                                          setState(() {
                                            showImage = false;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          'assets/img/detail.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (showImage)
                                    Padding(
                                      padding: EdgeInsets.zero, // 여백을 완전히 제거
                                      child: Image.asset(
                                        'assets/img/wash.png',
                                        width: 220,
                                        height: 220,
                                      ),
                                    ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ReservationMachinebox(
                                        machine: "1",
                                        machine_state:
                                            reservations[selectedIndex]
                                                .userCount[0],
                                        isActive: selectedMachine == 0,
                                        onTap: () {
                                          setState(() {
                                            if (selectedIndex == 4) {
                                              isReservationed = false;
                                            } else {
                                              isReservationed = true;
                                              selectedMachine = 0;
                                            }
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                      ReservationMachinebox(
                                        machine: "2",
                                        machine_state:
                                            reservations[selectedIndex]
                                                .userCount[1],
                                        isActive: selectedMachine == 1,
                                        onTap: () {
                                          setState(() {
                                            if (selectedIndex == 4) {
                                              isReservationed = false;
                                            } else {
                                              isReservationed = true;
                                              selectedMachine = 1;
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      ReservationMachinebox(
                                        machine: "3",
                                        machine_state:
                                            reservations[selectedIndex]
                                                .userCount[2],
                                        isActive: selectedMachine == 2,
                                        onTap: () {
                                          setState(() {
                                            if (selectedIndex == 4) {
                                              isReservationed = false;
                                            } else {
                                              isReservationed = true;
                                              selectedMachine = 2;
                                            }
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                      ReservationMachinebox(
                                        machine: "4",
                                        machine_state:
                                            reservations[selectedIndex]
                                                .userCount[3],
                                        isActive: selectedMachine == 3,
                                        onTap: () {
                                          setState(() {
                                            if (selectedIndex == 4) {
                                              isReservationed = false;
                                            } else {
                                              isReservationed = true;
                                              selectedMachine = 3;
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height > 740
                                ? MediaQuery.of(context).size.height *
                                    (78 / 852)
                                : MediaQuery.of(context).size.height *
                                    (20 / 852),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  isReservationed == true
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: ReservationCheckModal(
                                                date:
                                                    reservations[selectedIndex]
                                                        .date,
                                                onConfirm: () async {
                                                  print(
                                                      '${reservations[selectedIndex].date}');
                                                  print(
                                                      "${user_profile.washingRoom} 세탁기${selectedMachine + 1}");
                                                  ReservationPostApi postApi =
                                                      ReservationPostApi(
                                                          date:
                                                              '${reservations[selectedIndex].date}',
                                                          machine:
                                                              "${user_profile.washingRoom} 세탁기${selectedMachine + 1}");
                                                  postApi.reservationDate();
                                                },
                                              ),
                                            );
                                          },
                                        )
                                        :SizedBox(),
                                },
                                child: NextButton(
                                  text: '예약하기',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FinishPage()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('데이터를 불러올 수 없습니다.'));
            } else {
              return const Center(child: Text('예약이 없습니다.'));
            }
          },
        ),
      ),
    );
  }
}
