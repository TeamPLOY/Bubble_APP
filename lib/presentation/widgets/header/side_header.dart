import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/pages/home/home_page.dart';

class SideHeader extends StatelessWidget {
  late String text;
  SideHeader({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54,
      decoration: BoxDecoration(
          color: AppColor.white100,
          border: Border(
            bottom: BorderSide(width: 1.5, color: Color(0xffF2F5F7)),
          )),
      child: Row(
        children: [
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                  ),
                );
              },
              child: Container(
                width: 80,
                height: 24,
                child: SvgPicture.asset(
                  'assets/img/back.svg',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 1),
                child: Text(
                  '${text}',
                  style:
                      AppTextStyles.medium18.copyWith(color: AppColor.gray800),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
