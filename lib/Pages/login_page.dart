import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Components/Header/header.dart';
import 'package:bubble_app/Components/Box/inputbox.dart';
import 'package:bubble_app/Components/Button/reservationButton.dart';
import 'package:bubble_app/Pages/join_page.dart';
import 'package:bubble_app/Functions/emailsearch.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<bool> loginstate=[false,false];

  double pad = 38;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(text: '로그인'),
              SizedBox(height: 153,),

            ],
          ),  
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('안녕하세요 : )',style: bold30.copyWith(color: gray800),),
                Text('버블입니다. ',style: bold30.copyWith(color: gray800),),
                SizedBox(height: 32,),
                Inputbox(wsize: 345, hsize: 40, text: '아이디 입력', controller: idController),
                SizedBox(height: 20,),
                Inputbox(wsize: 345, hsize: 40, text: '비밀번호 입력', controller: passwordController),
                SizedBox(height: pad,),
                if(loginstate.every((element)=>element==true))Column(
                  children: [
                    Text('아이디 혹은 비밀번호가 일치하지 않습니다.',style: medium12.copyWith(color: red100),),
                    SizedBox(height: 8,),
                  ],
                ),
                
                
                GestureDetector(
                  onTap: (){
                    Emailsearch emailsearch= Emailsearch(emailController: idController, comController: passwordController);
                
                    setState(() {
                      loginstate=emailsearch.checkForm();
                      if(loginstate.every((element)=>element==true)){
                        pad=13;
                      }
                      else{
                        pad=38;
                      }
                    });
                
                  },
                  child: Reservationbutton(text: '로그인 하기')
                ),                
                SizedBox(height: 9,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
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
                      child: Text('비밀번호 찾기',style: bold12.copyWith(color: gray800),)
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
                      onTap: (){
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
                      child: Text('회원가입',style: bold12.copyWith(color: gray800),)
                    ),
                  ],
                ),

              ],
            ),
          )
          
        ],
      ),
    );
  }
}