import 'package:bubble_app/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/components/header/header.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/components/box/Textdown.dart';
import 'package:bubble_app/Utils/join.dart';
import 'package:bubble_app/Functions/use_text.dart';

class TermsUse extends StatefulWidget {
  final Join joins;
  const TermsUse({required this.joins,super.key});

  @override
  State<TermsUse> createState() => _TermsUseState();
}

class _TermsUseState extends State<TermsUse> {
  Color button_color1 = gray200;
  Color button_color2 = gray500;
  bool allcheckstatus = false;
  Color color1 = gray700;
  Color color2 = gray200;
  String svg_url = 'assets/img/check.svg';
  String svg_url1 = 'assets/img/checkgray.svg';
  String svg_url2 = 'assets/img/checkgray.svg';
  String svg_arrow = 'assets/img/arrow.svg';
  String svg_arrow2 = 'assets/img/arrow.svg';
  bool option1 = false;
  bool option2 = false;
  bool arrow_option1 = false;
  bool arrow_option2 = false;
  double pad = 390;
  bool buttonstatus = true;

  void option1_tade() {
    if (option1 == false) {
      setState(() {
        option1 = true;
        svg_url1 = 'assets/img/checkblue.svg';
      });
    } else if (option1 == true) {
      setState(() {
        option1 = false;
        svg_url1 = 'assets/img/checkgray.svg';
      });
    }
    updatecheck();
  }

  void option2_tade() {
    if (option2 == false) {
      setState(() {
        option2 = true;
        svg_url2 = 'assets/img/checkblue.svg';
      });
    } else if (option2 == true) {
      setState(() {
        option2 = false;
        svg_url2 = 'assets/img/checkgray.svg';
      });
    }
    updatecheck();
  }

  void updatecheck() {
    if (option1 && option2) {
      setState(() {
        button_color1=blue400;
        button_color2=white100;
        allcheckstatus = true;
        color1 = white100;
        color2 = blue400;
        svg_url = 'assets/img/checkwhite.svg';
      });
    } else {
      setState(() {
        allcheckstatus = false;
        button_color1=gray200;
        button_color2=gray500;
        color1 = gray700;
        color2 = gray200;
        svg_url = 'assets/img/check.svg';
      });
    }
  }

  void arrow_tade() {
    if (arrow_option1 == false) {
      setState(() {
        arrow_option1 = true;
        pad = pad - 164;
        svg_arrow = 'assets/img/arrowdown.svg';
      });
    } else if (arrow_option1 == true) {
      setState(() {
        pad = pad + 164;
        arrow_option1 = false;
        svg_arrow = 'assets/img/arrow.svg';
      });
    }
  }

  void arrow2_tade() {
    if (arrow_option2 == false) {
      setState(() {
        pad = pad - 164;
        arrow_option2 = true;
        svg_arrow2 = 'assets/img/arrowdown.svg';
      });
    } else if (arrow_option2 == true) {
      setState(() {
        pad = pad + 164;
        arrow_option2 = false;
        svg_arrow2 = 'assets/img/arrow.svg';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(text: '이용 약관'),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * (24 / 393)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이용 약관 동의',
                    style: semiBold24.copyWith(color: gray700),
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (allcheckstatus == false) {
                        setState(() {
                          button_color1=blue400;
                          button_color2=white100;
                          allcheckstatus = true;
                          color1 = white100;
                          color2 = blue400;
                          svg_url = 'assets/img/checkwhite.svg';
                          option1 = true;
                          svg_url1 = 'assets/img/checkblue.svg';
                          option2 = true;
                          svg_url2 = 'assets/img/checkblue.svg';
                        });
                      } else if (allcheckstatus == true) {
                        setState(() {
                          button_color1= gray200;
                          button_color2 = gray500;
                          allcheckstatus = false;
                          color1 = gray700;
                          color2 = gray200;
                          svg_url = 'assets/img/check.svg';
                          option1 = false;
                          svg_url1 = 'assets/img/checkgray.svg';
                          option2 = false;
                          svg_url2 = 'assets/img/checkgray.svg';
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * (345 / 393),
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8), color: color2),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 19),
                            child: SvgPicture.asset(
                              svg_url,
                              height: 19,
                              width: 19,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '네, 모두 동의합니다.',
                            style: semiBold16.copyWith(color: color1),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 19,
                      ),
                      GestureDetector(
                          onTap: () {
                            option1_tade();
                          },
                          child: SvgPicture.asset(
                            svg_url1,
                            width: 19,
                            height: 19,
                          )),
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        '이용약관 ',
                        style: semiBold16.copyWith(color: gray800),
                      ),
                      Text(
                        '(필수)',
                        style: semiBold16.copyWith(color: blue400),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  arrow_tade();
                                },
                                child: SvgPicture.asset(svg_arrow)),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (arrow_option1 == true)
                        Textdown(
                            text:first_text
                        )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 19,
                      ),
                      GestureDetector(
                          onTap: () {
                            option2_tade();
                          },
                          child: SvgPicture.asset(
                            svg_url2,
                            width: 19,
                            height: 19,
                          )),
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        '개인정보 처리방침 ',
                        style: semiBold16.copyWith(color: gray800),
                      ),
                      Text(
                        '(필수)',
                        style: semiBold16.copyWith(color: blue400),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  arrow2_tade();
                                },
                                child: SvgPicture.asset(svg_arrow2)),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (arrow_option2 == true)
                        Textdown(
                            text:second_text
                                 )
                    ],
                  ),
                  SizedBox(
                    height: pad,
                  ),
                  buttonstatus == false
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '약관에 동의해주세요',
                                  style: medium12.copyWith(color: red100),
                                )
                              ],
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 17,
                        ),
                  SizedBox(
                    height: 9,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (allcheckstatus == true) {
                          setState(() {
                            widget.joins.joinpostData();
                            buttonstatus = true;
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
                          });
                        } else {
                          setState(() {
                            buttonstatus = false;
                          });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width-48,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: button_color1
                        ),
                        child: Center(
                          child: Text('동의합니다',style: bold16.copyWith(color: button_color2),),
                        ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
