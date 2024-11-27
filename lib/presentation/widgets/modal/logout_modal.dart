import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/pages/login/login_page.dart';
import 'package:bubble_app/data/providers/network/apis/login/logout_api.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoutModal extends StatefulWidget {
  const LogoutModal({super.key});

  @override
  State<LogoutModal> createState() => _LogoutModalState();
}

class _LogoutModalState extends State<LogoutModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppColor.white100),
        width: MediaQuery.of(context).size.width * (350 / 393),
        height: 227,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
            ),
            SvgPicture.asset('assets/img/Mark.svg'),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '로그아웃',
                  style: AppTextStyles.bold20.copyWith(color: AppColor.gray800),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '정말로 계정에서 로그아웃하시겠습니까?',
              style: AppTextStyles.regular16.copyWith(color: AppColor.gray600),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () => {Navigator.pop(context, false)},
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColor.gray200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          '취소',
                          style: AppTextStyles.regular16
                              .copyWith(color: AppColor.gray700),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 12,
                ),
                GestureDetector(
                    onTap: () {
                      LogoutApi logout = LogoutApi();
                      logout.fetchData();

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  LoginPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child; // 애니메이션 없이 바로 화면 전환
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * (130 / 350),
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColor.blue400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          '확인',
                          style: AppTextStyles.regular16
                              .copyWith(color: AppColor.white100),
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
