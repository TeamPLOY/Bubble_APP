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

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  late Future<List<ReservationModel>> reservationsFuture;
  late UserModel user_profile;
  int selectedIndex = 0;
  int selectedMachine = -1;
  var access_token = globalTokens?.access_token ?? '';

  @override
  void initState() {
    super.initState();
    reservationsFuture = fetchReservations();
    fetchUser();
  }

  Future<List<ReservationModel>> fetchReservations() async {
    final reservationGetApi = ReservationGetApi();
    return await reservationGetApi.fetchData();
  }

  void fetchUser() async {
    final userGetapi = ProfileApi(access_token: access_token);
    user_profile = await userGetapi.fetchData();
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
              return ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideHeader(text: "예약"),
                      const SizedBox(height: 17),
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
                                        day: reservations[0].date,
                                        week: "월",
                                        isActive: selectedIndex == 0,
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 0;
                                            selectedMachine = -1;
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                      ReservationWeekbox(
                                        day: reservations[1].date,
                                        week: "화",
                                        isActive: selectedIndex == 1,
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 1;
                                            selectedMachine = -1;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      ReservationWeekbox(
                                        day: reservations[2].date,
                                        week: "수",
                                        isActive: selectedIndex == 2,
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 2;
                                            selectedMachine = -1;
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                      ReservationWeekbox(
                                        day: reservations[3].date,
                                        week: "목",
                                        isActive: selectedIndex == 3,
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 3;
                                            selectedMachine = -1;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        (40 / 852),
                                  ),
                                  Text(
                                    '희망하는 세탁기 선택',
                                    style: AppTextStyles.semiBold18
                                        .copyWith(color: AppColor.gray800),
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
                                            selectedMachine = 0;
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
                                            selectedMachine = 1;
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
                                            selectedMachine = 2;
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
                                            selectedMachine = 3;
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
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ReservationCheckModal(
                                          date:
                                              reservations[selectedIndex].date,
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
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }
}
