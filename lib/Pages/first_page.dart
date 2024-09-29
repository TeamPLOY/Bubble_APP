import 'package:bubble_app/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';

class  FirstPage extends StatelessWidget {
  const  FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: blue400
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left:16 ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (122 / 852),
                    ),
                    Image.asset('assets/img/BUBBLE.png'),
                    Text('한 번의 터치로 세탁 알림과 예약,',style: medium18.copyWith(color: gray100),),
                    Text('버블에서 시작하세요',style: medium18.copyWith(color: gray100),),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (207 / 852),
              ),
              Image.asset('assets/img/kuma.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height * (258 / 852),fit: BoxFit.fill,),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return child; // 애니메이션 없이 바로 화면 전환
                              },
                            ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: gray100
                    ),
                    child: Center(
                      child: Text('버블 시작',style: semiBold24.copyWith(color: blue400),),
                    ),
                  ),  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}