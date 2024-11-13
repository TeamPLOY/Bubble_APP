import 'package:flutter/material.dart';
import 'package:bubble_app/data/models/machine_model.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/data/providers/network/apis/machine/machine_get_api.dart';

class HomeActivate extends StatefulWidget {
  const HomeActivate({super.key});

  @override
  State<HomeActivate> createState() => _HomeActivateState();
}

class _HomeActivateState extends State<HomeActivate> {
  bool isWasherRunning = false;
  bool isDryerRunning = false;

  @override
  void initState() {
    super.initState();
    fetchMachineData();
  }

  Future<void> fetchMachineData() async {
    try {
      List<MachineModel> machineData = await MachineGetApi().fetchData();
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
                color: isWasherRunning ? AppColor.blue400 : AppColor.gray400,
                borderRadius: BorderRadius.circular(90),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                '세탁기',
                style: AppTextStyles.bold12.copyWith(color: AppColor.white100),
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
                color: isDryerRunning ? AppColor.blue400 : AppColor.gray400,
                borderRadius: BorderRadius.circular(90),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                '건조기',
                style: AppTextStyles.bold12.copyWith(color: AppColor.white100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
