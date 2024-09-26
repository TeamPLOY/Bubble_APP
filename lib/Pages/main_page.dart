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
                padding: const EdgeInsets.only(left: 30, right: 30, top: 180),
                child: FutureBuilder<List<Machine>>(
                  future: machineData,
                  builder: (context, futureResult) {
                    if (futureResult.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (futureResult.hasError) {
                      return Center(child: Text('에러: ${futureResult.error}'));
                    } else if (futureResult.data == null ||
                        futureResult.data!.isEmpty) {
                      return Center(child: Text('시간이 날라오고 잇어욤'));
                    }
            
                    final machines = futureResult.data!;
            
                    return ListView.builder(
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
                            double machineTime =
                                machine.time; // assuming time is in minutes
            
                            final hours =
                                (machineTime / 60).floor(); // Calculate hours
                            final minutes = (machineTime % 60)
                                .toInt(); // Calculate remaining minutes
            
                            final formattedHours =
                                hours.toString().padLeft(2, '0');
                            final formattedMinutes =
                                minutes.toString().padLeft(2, '0');
            
                            return Column(
                              children: [
                                Bubblebox(
                                  place: index + 1,
                                  hour: int.parse(formattedHours),
                                  minute: int.parse(formattedMinutes),
                                  device: machine.name,
                                ),
                                SizedBox(
                                  height: 16,
                                  width: 12,
                                ),
                              ],
                            );
                          }),
                        );
                      },
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
