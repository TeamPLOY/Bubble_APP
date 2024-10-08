import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/Pages/finish.dart';
import 'package:bubble_app/Utils/reservation_post.dart';

class CheckModal extends StatelessWidget {
  final Function onConfirm;
  final String date;

  CheckModal({required this.onConfirm, required this.date, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 251,
      decoration: BoxDecoration(
        color: white100,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1.5,
          color: blue400,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 39),
            child: SvgPicture.asset(
              'assets/img/checkicon.svg',
              width: 70,
              height: 70,
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
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 55,
                    height: 25,
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
                  width: 19,
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
                    width: 55,
                    height: 25,
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
