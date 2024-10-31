import 'package:bubble_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/Utils/machine_get.dart';
import 'package:bubble_app/Models/machine_model.dart';

class Check_Box extends StatefulWidget {
  const Check_Box({super.key});

  @override
  State<Check_Box> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<Check_Box> {
  bool isWasherRunning = false;
  bool isDryerRunning = false;

  @override
  void initState() {
    super.initState();
    fetchMachineData();
  }

  Future<void> fetchMachineData() async {
    try {
      List<Machine> machineData = await MachineGet().fetchData();
      setState(() {
        if (machineData.isNotEmpty) {
          isWasherRunning = machineData
              .any((machine) => machine.name == 'Washer' && machine.time > 0);
          isDryerRunning = machineData
              .any((machine) => machine.name == 'Dryer' && machine.time > 0);
        }
      });
    } catch (e) {
      print('Failed to fetch machine data: $e'); // 오류 처리 추가
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: isWasherRunning ? blue400 : gray400,
                borderRadius: BorderRadius.circular(90),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                '세탁기',
                style: bold12.copyWith(color: white100),
              ),
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width -
                    MediaQuery.of(context).padding.top) *
                0.014,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: isDryerRunning ? blue400 : gray400,
                borderRadius: BorderRadius.circular(90),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                '건조기',
                style: bold12.copyWith(color: white100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
