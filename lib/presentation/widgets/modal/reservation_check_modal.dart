import 'package:bubble_app/presentation/pages/home/home_page.dart';
import 'package:bubble_app/presentation/pages/reservation/finish_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';


class ReservationCheckModal extends StatelessWidget {
  final Function onConfirm;
  final String date;

  ReservationCheckModal({required this.onConfirm, required this.date, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width >= 400
          ? MediaQuery.of(context).size.width * (210 / 393)
          : 210,
      height: MediaQuery.of(context).size.width >= 700 ? 350 : 250,
      decoration: BoxDecoration(
        color: AppColor.white100,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1.5,
          color: AppColor.blue400,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: SvgPicture.asset(
              'assets/img/checkicon.svg',
              width: MediaQuery.of(context).size.width >= 700 ? 120 : 90,
              height: MediaQuery.of(context).size.width >= 700 ? 120 : 90,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Text(
                  '선택하신 날짜가 ${date.split('-')[1]}월 ${date.split('-')[2]}일입니다.',
                  style: TextStyle(
                    fontFamily: "PretendardMedium",
                    fontSize:
                        MediaQuery.of(context).size.width >= 700 ? 24 :MediaQuery.of(context).size.width >= 400 ? 18 : 12,
                  ),
                ),
                Text(
                  '이대로 진행 하시겠습니까?',
                  style: TextStyle(
                    fontFamily: "PretendardMedium",
                    fontSize:
                        MediaQuery.of(context).size.width >= 700 ? 24 :MediaQuery.of(context).size.width >= 400 ? 18 : 12,
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
                    width: MediaQuery.of(context).size.width >= 393
                        ? MediaQuery.of(context).size.width * (65 / 393)
                        : 55,
                    height: MediaQuery.of(context).size.width >= 700
                        ? MediaQuery.of(context).size.height * (60 / 893)
                        : 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1, color: AppColor.gray400),
                    ),
                    child: Center(
                      child: Text(
                        '아니오',
                        style: AppTextStyles.semiBold12
                            .copyWith(color: AppColor.gray500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 600
                      ? MediaQuery.of(context).size.height * (38 / 893)
                      : 19,
                ),
                GestureDetector(
                  onTap: () async {
                    await onConfirm();

                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FinishPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return child;
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width >= 393
                        ? MediaQuery.of(context).size.width * (65 / 393)
                        : 55,
                    height: MediaQuery.of(context).size.width >= 700
                        ? MediaQuery.of(context).size.height * (60 / 893)
                        : 25,
                    decoration: BoxDecoration(
                      color: AppColor.blue400,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1, color: Colors.transparent),
                    ),
                    child: Center(
                      child: Text(
                        '네',
                        style: AppTextStyles.semiBold12
                            .copyWith(color: AppColor.white100),
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
