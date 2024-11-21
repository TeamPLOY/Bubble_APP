import 'package:bubble_app/data/providers/network/apis/reservation/reservation_check_api.dart';
import 'package:bubble_app/presentation/pages/home/home_page.dart';
import 'package:bubble_app/presentation/widgets/modal/userfull_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/presentation/pages/profile/profile_page.dart';
import 'package:bubble_app/presentation/pages/reservation/reservation_page.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  bool? check_user;
  Future<void> get_user_state() async {
    ReservationCheckApi reservationCheckApi = ReservationCheckApi();

    bool result = await reservationCheckApi.fetchData();
    setState(() {
      check_user = result;
    });
    print(check_user);
  }

  @override
  void initState() {
    super.initState();
    get_user_state();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.white100,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  get_user_state();
                });
                if (check_user == true) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return UserfullModal();
                      });
                } else {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ReservationPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );
                }
              },
              icon: SvgPicture.asset(
                'assets/img/calendar.svg',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child; // 애니메이션 없이 바로 화면 전환
                    },
                  ),
                );
              },
              icon: SvgPicture.asset(
                'assets/img/home.svg',
                width: 23,
                height: 23,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ProfilePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child; // 애니메이션 없이 바로 화면 전환
                    },
                  ),
                );
              },
              icon: SvgPicture.asset(
                'assets/img/profile.svg',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
