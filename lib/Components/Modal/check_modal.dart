import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Pages/finish.dart';

class CheckModal extends StatelessWidget {
  final Function onConfirm;
  final String date;

  CheckModal({required this.onConfirm, required this.date, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width>=450?MediaQuery.of(context).size.width*(210/393):210,
      height: MediaQuery.of(context).size.width>=700?350:250,
      decoration: BoxDecoration(
        color: white100,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1.5,
          color: blue400,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 39),
            child: SvgPicture.asset(
              'assets/img/checkicon.svg',
              width: MediaQuery.of(context).size.width>=700?100 : 70,
              height: MediaQuery.of(context).size.width>=700?100 : 70,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Text(
                  '이대로 진행 하시겠습니까?',
                  style: TextStyle(
                    fontFamily: "PretendardMedium",
                    fontSize: MediaQuery.of(context).size.width>=700?24 : 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width>=393?MediaQuery.of(context).size.width*(55/393) : 55,
                    height: MediaQuery.of(context).size.width>=700?MediaQuery.of(context).size.height*(50/893) : 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1, color: gray400),
                    ),
                    child: Center(
                      child: Text(
                        '아니오',
                        style: semiBold10.copyWith(color: gray500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width>=600?MediaQuery.of(context).size.height*(38/893) : 19,
                ),
                GestureDetector(
                  onTap: () async {
                    // 날짜를 전달하는 onConfirm 함수 호출
                    await onConfirm();

                    // 데이터 전송 후 화면 이동
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Finish(title: "예약"),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return child;
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width>=393?MediaQuery.of(context).size.width*(55/393) : 55,
                    height: MediaQuery.of(context).size.width>=700?MediaQuery.of(context).size.height*(50/893) : 25,
                    decoration: BoxDecoration(
                      color: blue400,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1, color: Colors.transparent),
                    ),
                    child: Center(
                      child: Text(
                        '네',
                        style: semiBold10.copyWith(color: white100),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
