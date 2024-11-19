import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/presentation/pages/alarm/alarm_page.dart';

class MainHeader extends StatefulWidget {
  final bool hasAlarm;

  const MainHeader({super.key, required this.hasAlarm});

  @override
  State<MainHeader> createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {
  late bool alarmState;

  @override
  void initState() {
    super.initState();
    alarmState = widget.hasAlarm;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54,
      decoration: BoxDecoration(
        color: AppColor.white100,
        border: Border(
          bottom: BorderSide(width: 1.5, color: Color(0xffF2F5F7)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: SvgPicture.asset(
              'assets/img/home_logo.svg',
              width: 71,
              height: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  alarmState = false;
                });

                await Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AlarmPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: SvgPicture.asset(
                alarmState
                    ? 'assets/img/alarm_yes.svg'
                    : 'assets/img/alarm_no.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
