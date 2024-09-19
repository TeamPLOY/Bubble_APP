import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/theme.dart';

class Header extends StatelessWidget {
  late String text;
  Header({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.5, color: Color(0xffF2F5F7)),
      )),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
                onTap: () => {Navigator.of(context).pop()},
                child: SvgPicture.asset(
                  'assets/img/back.svg',
                  width: 8,
                  height: 18,
                )),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 28),
                child: Text(
                  '${text}',
                  style: medium16.copyWith(color: gray800),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
