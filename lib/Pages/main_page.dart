import 'package:bubble_app/Components/Box/checkbox.dart';
import 'package:bubble_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/Components/Box/bubblebox.dart';
import 'package:bubble_app/Components/Footer/footer.dart';
import 'package:bubble_app/Components/Header/main_header.dart';
import 'package:bubble_app/Models/machine_model.dart';
import 'package:bubble_app/Utils/machine_get.dart';
import 'package:bubble_app/Components/Box/noticebox.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List<Machine>>? machineData;

  @override
  void initState() {
    super.initState();
    _futureMachineData();
  }

  Future<void> _futureMachineData() async {
    MachineGet machine = MachineGet();
    try {
      List<Machine> fetchedMachine = await machine.fetchData();
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

    return Scaffold(
      backgroundColor: white100,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                MainHeader(hasAlarm: true),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "B 여자 세탁실",
                        style: medium22.copyWith(color: gray800),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        "남은 시간을 확인해보세요!",
                        style: medium16.copyWith(color: gray800),
                      ),
                      SizedBox(height: screenHeight * 0.012),
                      Noticebox(),
                      SizedBox(height: screenHeight * 0.025),
                      Check_Box(),
                      SizedBox(height: screenHeight * 0.016),
                      FutureBuilder<List<Machine>>(
                        future: machineData,
                        builder: (context, futureResult) {
                          if (futureResult.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (futureResult.hasError) {
                            return Center(
                                child: Text('에러: ${futureResult.error}'));
                          } else if (futureResult.data == null ||
                              futureResult.data!.isEmpty) {
                            return Center(child: Text('시간이 날라오고 있어요.'));
                          }

                          final machines = futureResult.data!;

                          return LayoutBuilder(
                            builder: (context, constraints) {
                              int columns = constraints.maxWidth > 600 ? 2 : 1;
                              double boxWidth =
                                  constraints.maxWidth / columns - 20;

                              return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: machines.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columns,
                                  mainAxisSpacing: screenHeight * 0.02,
                                  crossAxisSpacing: 20.0,
                                  childAspectRatio: 3 / 2,
                                ),
                                itemBuilder: (context, index) {
                                  final machine = machines[index];
                                  double machineTime = machine.time;
                                  final hours = (machineTime / 60).floor();
                                  final minutes = (machineTime % 60).toInt();

                                  final formattedHours =
                                      hours.toString().padLeft(2, '0');
                                  final formattedMinutes =
                                      minutes.toString().padLeft(2, '0');

                                  return Container(
                                    width: boxWidth,
                                    child: Column(
                                      children: [
                                        Bubblebox(
                                          place: index - 3,
                                          hour: int.parse(formattedHours),
                                          minute: int.parse(formattedMinutes),
                                          device: machine.name,
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.016,
                                        ),
                                      ],
                                    ),
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
              child: Footer(),
            ),
          ],
        ),
      ),
    );
  }
}
