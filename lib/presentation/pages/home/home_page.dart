import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/widgets/box/machine_box.dart';
import 'package:bubble_app/data/models/machine_model.dart';
import 'package:bubble_app/data/providers/network/apis/machine/machine_get_api.dart';
import 'package:bubble_app/presentation/widgets/header/main_header.dart';
import 'package:bubble_app/presentation/widgets/bottom/bottom.dart';
import 'package:bubble_app/presentation/widgets/box/home_notice_box.dart';
import 'package:bubble_app/presentation/widgets/box/home_activate.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bubble_app/data/models/user_model.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/providers/network/apis/profile/profile_api.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<MachineModel>>? machineData;
  var messageString = "";
  late String roomname;
  String? washingroom_text;
  Timer? _machineTimer;

  @override
  void initState() {
    super.initState();
    _futureMachineData();
    _setupMessageListener();

    // 1분마다 데이터 갱신
    _machineTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _futureMachineData();
    });

    getuserstaet();
  }

  void _setupMessageListener() {
    // 포그라운드 메시지 처리
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        messageString = message.notification?.body ?? '';
        print("메시지 수신: $messageString");
      });
    });
  }

  Future<void> getuserstaet() async {
    var access_token = globalTokens?.access_token;
    ProfileApi get_profile = ProfileApi(access_token: access_token);
    UserModel user = await get_profile.fetchData();

    if (user.roomNum[0] == 'B') {
      if (user.roomNum[1] == '4') {
        if (user.washingRoom == 'B42') {
          washingroom_text = 'B동 여자 세탁실';
        } else {
          washingroom_text = 'B동 B41 세탁실';
        }
      } else if (user.roomNum[1] == '3') {
        washingroom_text = 'B동 ${user.washingRoom} 세탁실';
      }
    } else if (user.roomNum[0] == 'A') {
      washingroom_text = 'A동 세탁실';
    }
  }

  Future<void> _futureMachineData() async {
    MachineGetApi machine = MachineGetApi();
    try {
      List<MachineModel> fetchedMachine = await machine.fetchData();

      // 서버에 현재 FCM 토큰 전송
      await _sendFCMTokenToServer();

      setState(() {
        machineData = Future.value(fetchedMachine);
      });
    } catch (e) {
      print('에러 $e');
    }
  }

  // FCM 토큰을 서버에 전송
  Future<void> _sendFCMTokenToServer() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        var access_token = globalTokens?.access_token;
        // TODO: FCM 토큰을 서버에 전송하는 API 호출
        // await FCMTokenApi(access_token: access_token).sendToken(token);
        print('FCM 토큰: $token');
      }
    } catch (e) {
      print('FCM 토큰 전송 실패: $e');
    }
  }

  @override
  void dispose() {
    _machineTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double paddingValue = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: AppColor.white100,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                MainHeader(hasAlarm: true),
                Padding(
                  padding:
                      EdgeInsets.only(left: paddingValue, top: paddingValue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ${washingroom_text == null ? "로딩 중" : washingroom_text}",
                        style: AppTextStyles.medium22
                            .copyWith(color: AppColor.gray800),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        "남은 시간을 확인해보세요!",
                        style: AppTextStyles.medium16
                            .copyWith(color: AppColor.gray800),
                      ),
                      SizedBox(height: screenHeight * 0.012),
                      MainNoticeBox(),
                      SizedBox(height: screenHeight * 0.025),
                      HomeActivate(),
                      SizedBox(height: screenHeight * 0.016),
                      FutureBuilder<List<MachineModel>>(
                        future: machineData,
                        builder: (context, futureResult) {
                          if (futureResult.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (futureResult.hasError) {
                            return Center(
                              child: Text('에러: ${futureResult.error}',
                                  style: AppTextStyles.regular14
                                      .copyWith(color: AppColor.red300)),
                            );
                          } else if (futureResult.data == null ||
                              futureResult.data!.isEmpty) {
                            return Center(
                              child: Text('시간이 날라오고 있어요.',
                                  style: AppTextStyles.regular14
                                      .copyWith(color: AppColor.gray500)),
                            );
                          }

                          final machines = futureResult.data!;

                          return LayoutBuilder(
                            builder: (context, constraints) {
                              double boxWidth = constraints.maxWidth * 0.4;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: (machines.length / 2).ceil(),
                                itemBuilder: (context, rowIndex) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(2, (colIndex) {
                                      int index = rowIndex * 2 + colIndex;
                                      if (index >= machines.length)
                                        return Container();

                                      final machine = machines[index];
                                      double machineTime = machine.time;
                                      final hours = (machineTime / 60).floor();
                                      final minutes =
                                          (machineTime % 60).toInt();

                                      final formattedHours =
                                          hours.toString().padLeft(2, '0');
                                      final formattedMinutes =
                                          minutes.toString().padLeft(2, '0');

                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: colIndex == 0
                                                ? paddingValue
                                                : 0.0),
                                        child: Container(
                                          width: boxWidth,
                                          child: Column(
                                            children: [
                                              MachineBox(
                                                place: index - 3,
                                                hour: int.parse(formattedHours),
                                                minute:
                                                    int.parse(formattedMinutes),
                                                device: machine.name,
                                              ),
                                              SizedBox(
                                                  height: screenHeight * 0.016),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Bottom(),
            ),
          ],
        ),
      ),
    );
  }
}
