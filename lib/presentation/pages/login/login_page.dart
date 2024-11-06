import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/pages/home/home_page.dart';
import 'package:bubble_app/presentation/widgets/button/next_button.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/presentation/pages/profile/profile_page.dart';
import 'package:bubble_app/presentation/widgets/box/input_box.dart';
import 'package:bubble_app/data/providers/network/apis/login/login_api.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/presentation/pages/signup/signup_page.dart';
import 'package:bubble_app/data/Functions/emailsearch.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<bool> loginstate = [false, false];
  double pad = 42;
  bool logcheck = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100, // AppColor 사용
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SideHeader(text: '로그인'),
                SizedBox(height: 107),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '안녕하세요 : )',
                    style: AppTextStyles.bold30
                        .copyWith(color: AppColor.gray800), // AppTextStyles 사용
                  ),
                  Text(
                    '버블입니다.',
                    style: AppTextStyles.bold30
                        .copyWith(color: AppColor.gray800), // AppTextStyles 사용
                  ),
                  SizedBox(height: 30),
                  Inputbox(
                    wsize: 345,
                    hsize: 40,
                    text: '아이디 입력',
                    controller: idController,
                  ),
                  SizedBox(height: 14),
                  Inputbox(
                    wsize: 345,
                    hsize: 40,
                    text: '비밀번호 입력',
                    controller: passwordController,
                    password: true,
                  ),
                  SizedBox(height: pad),
                  if (loginstate[0] == true || loginstate[1] == true)
                    Column(
                      children: [
                        Text(
                          '이메일 혹은 비밀번호가 비어있습니다.',
                          style: AppTextStyles.medium12.copyWith(
                              color: AppColor.red100), // AppTextStyles 사용
                        ),
                        SizedBox(height: 17),
                      ],
                    ),
                  if (logcheck == false)
                    Column(
                      children: [
                        Text(
                          '이메일 혹은 비밀번호가 일치하지 않습니다.',
                          style: AppTextStyles.medium12.copyWith(
                              color: AppColor.red100), // AppTextStyles 사용
                        ),
                        SizedBox(height: 17),
                      ],
                    ),
                  GestureDetector(
                    onTap: () async {
                      Emailsearch emailsearch = Emailsearch(
                        emailController: idController,
                        comController: passwordController,
                      );

                      setState(() {
                        loginstate = emailsearch.checkForm();
                        pad = loginstate[0] || loginstate[1] ? 8 : 42;
                      });

                      if (!loginstate[0] && !loginstate[1]) {
                        LoginApi login = LoginApi(
                          email: idController.text,
                          password: passwordController.text,
                        );
                        globalTokens = await login.loginpostData();

                        setState(() {
                          if (globalTokens?.access_token == null ||
                              globalTokens?.refresh_token == null) {
                            pad = 8;
                            logcheck = false;
                          } else {
                            pad = 42;
                            logcheck = true;
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        HomePage(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return child;
                                },
                              ),
                            );
                          }
                        });
                      }
                    },
                    child: NextButton(
                      text: '로그인 하기',
                      onPressed: () {}, 
                    ),
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ProfilePage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return child;
                              },
                            ),
                          );
                        },
                        child: Text(
                          '비밀번호 찾기',
                          style: AppTextStyles.bold12.copyWith(
                              color: AppColor.gray800), // AppTextStyles 사용
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 1,
                        height: 13.5,
                        color: AppColor.gray500, // AppColor 사용
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SignupPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return child;
                              },
                            ),
                          );
                        },
                        child: Text(
                          '회원가입',
                          style: AppTextStyles.bold12.copyWith(
                              color: AppColor.gray800), // AppTextStyles 사용
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
