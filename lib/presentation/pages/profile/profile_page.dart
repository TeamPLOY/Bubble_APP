import 'package:bubble_app/presentation/pages/deleteUser/del_page.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/presentation/widgets/text/profile_text.dart';
import 'package:bubble_app/presentation/widgets/modal/logout_modal.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/providers/network/apis/profile/profile_api.dart';
import 'package:bubble_app/data/models/user_model.dart';

const String svgsetimage = 'assets/img/setimage.svg';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  final String instagramUrl =
      "https://www.instagram.com/bssm_ploy?igsh=bTMzemExbXN6MG83";

  Future<void> _fetchUserData() async {
    ProfileApi users = ProfileApi(access_token: globalTokens?.access_token);
    try {
      UserModel fetchedUser = await users.fetchData();
      setState(() {
        userData = fetchedUser;
      });
    } catch (e) {
      print('에러: ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100, // AppColor 사용
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideHeader(text: '마이페이지'),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.gray300, width: 1), // AppColor 사용
                          shape: BoxShape.circle),
                      child: ClipOval(
                        child: Image.network(
                          'https://i.namu.wiki/i/Bge3xnYd4kRe_IKbm2uqxlhQJij2SngwNssjpjaOyOqoRhQlNwLrR2ZiK-JWJ2b99RGcSxDaZ2UCI7fiv4IDDQ.webp',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 13),
                    child: Column(
                      children: [
                        Text(
                          userData != null ? '${userData!.name}' : '이름 로딩 중...',
                          style: AppTextStyles.semiBold16.copyWith(
                              color: AppColor.gray800), // AppTextStyles 사용
                        ),
                        Text(
                          userData != null
                              ? '${userData!.studentNum}'
                              : '학생 번호 로딩 중...',
                          style: AppTextStyles.medium12.copyWith(
                              color: AppColor.gray600), // AppTextStyles 사용
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 14),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이메일',
                      style: AppTextStyles.medium14.copyWith(
                          color: AppColor.gray800), // AppTextStyles 사용
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (3 / 852),
                    ),
                    ProfileText(
                      information: userData != null
                          ? '${userData!.email}'
                          : '이메일 로딩 중...',
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '호실',
                      style: AppTextStyles.medium14.copyWith(
                          color: AppColor.gray800), // AppTextStyles 사용
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (3 / 852),
                    ),
                    ProfileText(
                      information: userData != null
                          ? '${userData!.roomNum}'
                          : '호실 로딩 중...',
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 80),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (200 / 852),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LogoutModal();
                          },
                        );
                      },
                      child: Text(
                        '로그아웃',
                        style: AppTextStyles.regular14.copyWith(
                            color: AppColor.gray600), // AppTextStyles 사용
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DelPage();
                          },
                        );
                      },
                      child: Text(
                        '탈퇴하기',
                        style: AppTextStyles.regular14.copyWith(
                            color: AppColor.red100), // AppTextStyles 사용
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
