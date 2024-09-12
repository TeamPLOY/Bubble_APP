import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/theme.dart';

class LaunduringBox extends StatefulWidget {
  late int hour, minute, place;
  late String device;
  LaunduringBox(
      {required this.place,
      required this.hour,
      required this.minute,
      required this.device,
      super.key});

  @override
  State<LaunduringBox> createState() => _LaunduringBoxState();
}

class _LaunduringBoxState extends State<LaunduringBox> {
  int alram_onff = 0;
  String alram_url = 'assets/img/alram_no.svg';
  String formattime(int time) {
    return time.toString().padLeft(2, '0');
  }

  void alramchange() {
    setState(() {
      if (alram_onff == 0) {
        alram_url = 'assets/img/alram_yes.svg';
        alram_onff = 1;
      } else if (alram_onff == 1) {
        alram_url = 'assets/img/alram_no.svg';
        alram_onff = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 113,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(width: 1, color: gray300)),
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 11, right: 15.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${widget.device}',
                        style: medium14.copyWith(color: gray800),
                      ),
                      Lightbox(selectedIndex: widget.place),
                    ],
                  ),
                  GestureDetector(
                      onTap: () => {alramchange()},
                      child: SvgPicture.asset(
                        alram_url,
                        width: 19,
                        height: 20,
                      )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 13),
                child: Row(
                  children: [
                    Text(
                      '${widget.device}',
                      style: medium10.copyWith(color: gray800),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.hour == 0 && widget.minute == 0
                              ? gray300
                              : red100),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    width: 132,
                    height: 26,
                    decoration: BoxDecoration(
                        color: gray200, borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7),
                          child: Text(
                            '${formattime(widget.hour)}:${formattime(widget.minute)}',
                            style: medium12.copyWith(color: gray400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Lightbox extends StatelessWidget {
  final int selectedIndex;

  const Lightbox({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: List.generate(2, (index) {
                int number = index + 1;
                return Padding(
                  padding: const EdgeInsets.only(right: 1, top: 1),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: selectedIndex == number
                          ? blue400
                          : blue100, // 조건에 따라 색상 변경
                    ),
                  ),
                );
              }),
            ),
          ),
          Row(
            children: List.generate(4, (index) {
              int number = index + 3;
              return Padding(
                padding: const EdgeInsets.only(right: 1, top: 1),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: selectedIndex == number
                        ? blue400
                        : blue100, // 조건에 따라 색상 변경
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
