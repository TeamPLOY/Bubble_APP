import 'package:bubble_app/presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginHeader extends StatelessWidget {
  late String text;
  LoginHeader({required this.text, super.key});

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
          
            children: [
              Positioned(child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        LoginPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/img/back.svg',
                width: 71,
                height: 20,
              ),
            ),
          ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                                    '${text}',
                                                    style: AppTextStyles.medium16.copyWith(color: AppColor.gray800),
                                                  ),
                              ],
                            ),
            ],
          ),
        ],
      ),
    );
  }
}
