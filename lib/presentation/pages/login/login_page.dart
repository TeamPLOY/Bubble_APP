import 'package:bubble_app/presentation/widgets/header/login_header.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/pages/home/home_page.dart';
import 'package:bubble_app/presentation/widgets/button/next_button.dart';
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
  double pad = 12;
  bool logcheck = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100, // AppColor 사용
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoginHeader(text: '로그인'),
            SizedBox(height: 107),
            Container(
              width: MediaQuery.of(context).size.width * (345 / 393),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '안녕하세요 \n버블에 오신 것을 환영합니다!',
                        style: MediaQuery.of(context).size.width>=750?AppTextStyles.bold30.copyWith(fontSize: 38)
                            .copyWith(color: AppColor.gray800): AppTextStyles.bold30
                            .copyWith(color: AppColor.gray800),
                        textAlign: TextAlign.left,
                      ),
                    ],
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
                  SizedBox(height: 8),
                  if (loginstate[0] == true || loginstate[1] == true)
                    Column(
                      children: [
                        Text(
                          '이메일 혹은 비밀번호가 비어있습니다.',
                          style:  MediaQuery.of(context).size.width>=750?AppTextStyles.medium18.copyWith(
                              color: AppColor.red100):AppTextStyles.medium12.copyWith(
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
                          style:  MediaQuery.of(context).size.width>=750?AppTextStyles.medium18.copyWith(
                              color: AppColor.red100):AppTextStyles.medium12.copyWith(
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
                            pad = 12;
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
                      text: '로그인',
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 14),
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
                      style: AppTextStyles.bold16.copyWith(
                          color: AppColor.gray800), // AppTextStyles 사용
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
