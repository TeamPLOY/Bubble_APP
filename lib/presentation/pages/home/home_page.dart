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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<MachineModel>>? machineData;
  var messageString = "";

  @override
  void initState() {
    super.initState();
    _futureMachineData();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );

        setState(() {
          messageString = message.notification!.body!;
          print("Foreground 메시지 수신: $messageString");
        });
      }
    });
  }

  Future<void> _futureMachineData() async {
    MachineGetApi machine = MachineGetApi();
    try {
      List<MachineModel> fetchedMachine = await machine.fetchData();
      setState(() {
        machineData = Future.value(fetchedMachine);
      });
    } catch (e) {
      print('에러 $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // 반응형 패딩 값 계산
    double paddingValue = screenWidth * 0.05; // 화면 너비의 5%를 패딩으로 설정

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
                        "메시지 내용: $messageString\nB 여자 세탁실",
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
