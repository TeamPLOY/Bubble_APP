import 'package:bubble_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/Components/Box/bubblebox.dart';
import 'package:bubble_app/Components/Footer/footer.dart';
import 'package:bubble_app/Components/Header/main_header.dart';
import 'package:bubble_app/Models/machine_model.dart';
import 'package:bubble_app/Utils/machine_get.dart';

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
      print('에러 ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainHeader(hasAlarm: true),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 40),
                child: FutureBuilder<List<Machine>>(
                  future: machineData,
                  builder: (context, futureResult) {
                    if (futureResult.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (futureResult.hasError) {
                      return Center(child: Text('에러: ${futureResult.error}'));
                    } else if (futureResult.data == null || futureResult.data!.isEmpty) {
                      return Center(child: Text('시간이 날라오고 잇어욤'));
                    }

                    final machines = futureResult.data!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('B동 남자 세탁실',style: semiBold18.copyWith(color: gray800),),
                                  Text('남은 시간을 확인해보세요!',style: medium14.copyWith(color: gray800),),
                                  SizedBox(height: 16,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*(335/393),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: gray200
                                    ),
                                    child: Center(
                                      child: Text('세탁기 섬유유연제는 두통을 유발하니 자제해주세요.',style: medium12.copyWith(color: gray600),),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: blue400,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        width: 50,
                                        height: 20,
                                        child: Center(child: Text('세탁기',style: regular12.copyWith(color: white100),)),
                                      ),
                                      SizedBox(width: 5,),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: blue400,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        width: 50,
                                        height: 20,
                                        child: Center(child: Text('건조기',style: regular12.copyWith(color: white100),)),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: (machines.length / 2).ceil(),
                            itemBuilder: (context, rowIndex) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(2, (colIndex) {
                                  int index = rowIndex * 2 + colIndex;
                                  if (index >= machines.length) {
                                    return Container();
                                  }
                                  final machine = machines[index];
                                  double machineTime = machine.time; // assuming time is in minutes

                                  final hours = (machineTime / 60).floor(); // Calculate hours
                                  final minutes = (machineTime % 60).toInt(); // Calculate remaining minutes

                                  final formattedHours = hours.toString().padLeft(2, '0');
                                  final formattedMinutes = minutes.toString().padLeft(2, '0');

                                  return Column (
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * (20 / 393)),
                                        child:  Bubblebox(
                                          place: index + 1,
                                          hour: int.parse(formattedHours),
                                          minute: int.parse(formattedMinutes),
                                          device: machine.name,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
