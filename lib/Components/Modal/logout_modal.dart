import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Utils/logout.dart';
import 'package:bubble_app/Pages/login_page.dart';

class LogoutModal extends StatefulWidget {
  const LogoutModal({super.key});

  @override
  State<LogoutModal> createState() => _LogoutModalState();
}

class _LogoutModalState extends State<LogoutModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 360,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 17,left: 18),
              child: Text('정말 로그아웃 하시겠습니까?',style: medium16.copyWith(color: gray800),),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14,right: 21),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context).pop()
                      },
                      child: Text('취소',style: semiBold12.copyWith(color: gray600),)
                    ),
                    SizedBox(width: 12,),
                    GestureDetector(
                      onTap: (){
                        Logout logout= Logout();
                        logout.fetchData();


                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      LoginPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return child; // 애니메이션 없이 바로 화면 전환
                              },
                            ),
                          );
                      },
                      child: Text('로그아웃',style: semiBold12.copyWith(color: Color(0xff1C4EFF)),)
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}