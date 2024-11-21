import 'package:bubble_app/data/models/token_model.dart';
import 'package:bubble_app/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/presentation/pages/login/login_page.dart';
import 'package:bubble_app/data/providers/network/security_storage.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});
  SecurityStorage storage = SecurityStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: MediaQuery.of(context).size.height >= 500
                          ? MediaQuery.of(context).size.height * (150 / 852)
                          : MediaQuery.of(context).size.height * (80 / 852),
                    ),
                    SvgPicture.asset(
                      'assets/img/bubble.svg',
                    ),
                    Text(
                      '한 번의 터치로 세탁 알림과 예약,',
                      style: AppTextStyles.medium18.copyWith(
                          color: AppColor.gray100), // AppTextStyles 사용
                    ),
                    Text(
                      '버블에서 시작하세요',
                      style: AppTextStyles.medium18.copyWith(
                          color: AppColor.gray100), // AppTextStyles 사용
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width >= 500 ||
                        MediaQuery.of(context).size.height <= 620
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
                    ? MediaQuery.of(context).size.height * (300 / 852)
                    : MediaQuery.of(context).size.height * (240 / 852),
                fit: BoxFit.fill,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    // SecureStorage에서 토큰 읽기
                    final accessToken = await storage.readSecureToken('accessToken');
                    final refreshToken = await storage.readSecureToken('refreshToken');

                    // 토큰이 null 또는 빈 문자열인지 확인
                    if (accessToken != null && accessToken.isNotEmpty) {
                      // TokenModel로 토큰 저장
                      TokenModel logintoken = TokenModel(
                        access_token: accessToken,
                        refresh_token: refreshToken,
                      );

                      // 글로벌 변수에 저장
                      globalTokens = logintoken;

                      // 자동 로그인 후 홈 페이지로 이동
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) => child,
                        ),
                      );
                    } else {
                      // 토큰이 없으면 로그인 페이지로 이동
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) => child,
                        ),
                      );
                    }
                  } catch (e) {
                    // 에러 발생 시 로그인 페이지로 이동
                    print('자동 로그인 실패: $e');
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) => child,
                      ),
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * (80 / 852),
                  decoration: BoxDecoration(color: AppColor.gray100),
                  child: Center(
                    child: Text(
                      '버블 시작',
                      style: AppTextStyles.bold20.copyWith(
                        color: AppColor.blue400,
                        fontSize: MediaQuery.of(context).size.height * (30 / 852),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
