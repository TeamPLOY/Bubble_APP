import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/pages/login/login_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.blue400,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(

              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height >= 500 ? MediaQuery.of(context).size.height * (80 / 852):MediaQuery.of(context).size.height * (50 / 852),
                      ),
                      Image.asset('assets/img/BUBBLE.png'),
                      Text(
                        '한 번의 터치로 세탁 알림과 예약,',
                        style: AppTextStyles.medium18.copyWith(
                            color: AppColor.gray100,fontSize: MediaQuery.of(context).size.height *
                                (24 / 852),), // AppTextStyles 사용
                      ),
                      Text(
                        '버블에서 시작하세요',
                        style: AppTextStyles.medium18.copyWith(
                            color: AppColor.gray100,fontSize: MediaQuery.of(context).size.height *
                                (18 / 852),), // AppTextStyles 사용
                      ),
                    ],
                  ),
                ),
                SizedBox(
                height: MediaQuery.of(context).size.width >= 500 ||MediaQuery.of(context).size.height <= 620 
                    ? MediaQuery.of(context).size.height * (100 / 852)
                    : MediaQuery.of(context).size.height * (207 / 852),
              ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                'assets/img/kuma.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width >= 500 
                    ? MediaQuery.of(context).size.height * (350 / 852)
                    : MediaQuery.of(context).size.height * (258 / 852),
                fit: BoxFit.fill,
              ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            LoginPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return child; // 애니메이션 없이 바로 화면 전환
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*(50/852),
                    decoration:
                        BoxDecoration(color: AppColor.gray100), // AppColor 사용
                    child: Center(
                      child: Text(
                        '버블 시작',
                        style: AppTextStyles.semiBold24.copyWith(
                            color: AppColor.blue500, // 다른 파란색으로 변경
                            fontSize: MediaQuery.of(context).size.height *
                                (24 / 852)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
