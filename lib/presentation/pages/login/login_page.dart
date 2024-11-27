import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/presentation/pages/profile/profile_page.dart';
import 'package:bubble_app/presentation/pages/signup/signup_page.dart';
import 'package:bubble_app/presentation/widgets/box/password_box.dart';
import 'package:bubble_app/presentation/widgets/header/login_header.dart';
import 'package:bubble_app/presentation/widgets/text/input_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/pages/home/home_page.dart';
import 'package:bubble_app/presentation/widgets/button/next_button.dart';
import 'package:bubble_app/presentation/widgets/box/input_box.dart';
import 'package:bubble_app/data/providers/network/apis/login/login_api.dart';
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
  String? userInfo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    if (userInfo != null) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100,
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
                        '안녕하세요:) \n버블에 오신 것을 환영합니다.',
                        style: MediaQuery.of(context).size.width >= 750
                            ? AppTextStyles.bold30
                                .copyWith(fontSize: 38)
                                .copyWith(color: AppColor.gray800)
                            : MediaQuery.of(context).size.width <= 400
                                ? AppTextStyles.bold20
                                    .copyWith(color: AppColor.gray800)
                                : MediaQuery.of(context).size.width <= 300
                                    ? AppTextStyles.bold20
                                        .copyWith(color: AppColor.gray800)
                                    : AppTextStyles.bold30
                                        .copyWith(color: AppColor.gray800),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  const InputTitle(text: '이메일'),
                  Inputbox(
                    wsize: 345,
                    hsize: 40,
                    text: '이메일',
                    controller: idController,
                  ),
                  SizedBox(height: 12),
                  const InputTitle(text: '비밀번호'),
                  PasswordBox(
                    wsize: 345,
                    hsize: 40,
                    text: '비밀번호',
                    controller: passwordController,
                  ),
                  SizedBox(height: 20),
                  if (loginstate[0] == true || loginstate[1] == true)
                    Column(
                      children: [
                        Text(
                          '이메일 혹은 비밀번호가 비어있습니다.',

                          style: MediaQuery.of(context).size.width >= 750
                              ? AppTextStyles.medium18
                                  .copyWith(color: AppColor.red100)
                              : AppTextStyles.medium12.copyWith(
                                  color: AppColor.red100), // AppTextStyles 사용
                        ),
                        SizedBox(height: 18),
                      ],
                    ),
                  if (logcheck == false)
                    Column(
                      children: [
                        Text(
                          '이메일 혹은 비밀번호가 일치하지 않습니다.',
                          style: MediaQuery.of(context).size.width >= 750
                              ? AppTextStyles.medium18
                                  .copyWith(color: AppColor.red100)
                              : AppTextStyles.medium12.copyWith(
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
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  SignupPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: '아직 계정이 없으신가요?',
                        style: AppTextStyles.regular16
                            .copyWith(color: AppColor.gray600),
                        children: [
                          TextSpan(
                            text: ' 회원가입하기',
                            style: AppTextStyles.regular16
                                .copyWith(color: AppColor.gray800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
