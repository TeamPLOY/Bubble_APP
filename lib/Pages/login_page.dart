import 'package:bubble_app/Components/Button/bluebutton.dart';
import 'package:bubble_app/Pages/my_page.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Components/Header/header.dart';
import 'package:bubble_app/Components/Box/inputbox.dart';
import 'package:bubble_app/Utils/login_post.dart';
import 'package:bubble_app/Pages/join_page.dart';
import 'package:bubble_app/Functions/emailsearch.dart';
import 'package:bubble_app/Utils/tokens.dart';
import 'package:bubble_app/pages/main_page.dart';

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
  bool logcheck=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Header(text: '로그인'),
                SizedBox(height: 107,),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('안녕하세요 : )', style: bold30.copyWith(color: gray800),),
                  Text('버블입니다. ', style: bold30.copyWith(color: gray800),),
                  SizedBox(height: 30,),
                  Inputbox(wsize: 345, hsize: 40, text: '아이디 입력', controller: idController),
                  SizedBox(height: 14,),
                  Inputbox(wsize: 345, hsize: 40, text: '비밀번호 입력', controller: passwordController,password: true,),
                  SizedBox(height: pad,),
                  if (loginstate[0]==true || loginstate[1]==true) Column(
                    children: [
                      Text('이메일 혹은 비밀번호가 비어있습니다.', style: medium12.copyWith(color: red100),),
                      SizedBox(height: 17,),
                    ],
                  ),
                  if (logcheck==false) Column(
                    children: [
                      Text('이메일 혹은 비밀번호가 일치하지 않습니다.', style: medium12.copyWith(color: red100),),
                      SizedBox(height: 17,),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Emailsearch emailsearch = Emailsearch(emailController: idController, comController: passwordController);
                      
                      setState(() {
                        loginstate = emailsearch.checkForm();
                        if (loginstate[0] || loginstate[1]) {
                          pad = 8;
                        } else {
                          pad = 42;
                        }
                      });
        
                      if (!loginstate[0] && !loginstate[1]) {
                        // 비동기 작업을 setState 밖에서 수행
                        LoginPost login = LoginPost(email: idController.text, password: passwordController.text);
                        globalTokens = await login.loginpostData();
        
                        // 비동기 작업 후 state를 업데이트
                        setState(() {
                          if (globalTokens?.access_token == null || globalTokens?.refresh_token == null) {
                            print("로그인 실패");
                            pad = 8;
                            logcheck=false;
                          }
                          else{
                            print('로그인 성공');
                            pad = 42;
                            logcheck=true;
                            Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return child; // 애니메이션 없이 바로 화면 전환
                              },
                            ),
                          );
                          }
                        });
                      }
                    },
                    child: Bluebutton(text: '로그인 하기'),
                  ),
        
                  SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => MyPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return child; // 애니메이션 없이 바로 화면 전환
                              },
                            ),
                          );
                        },
                        child: Text('비밀번호 찾기', style: bold12.copyWith(color: gray800),),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 1,
                        height: 13.5,
                        decoration: BoxDecoration(
                          color: gray500
                        ),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => JoinPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return child; // 애니메이션 없이 바로 화면 전환
                              },
                            ),
                          );
                        },
                        child: Text('회원가입', style: bold12.copyWith(color: gray800),),
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
