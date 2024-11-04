import 'package:flutter/material.dart';
import 'package:bubble_app/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  Future<void> _fetchUserData() async {
    ProfileApi users = ProfileApi(access_token: globalTokens?.access_token);
    try {
      UserModel fetchedUser = await users.fetchData();
      setState(() {
        userData = fetchedUser;
      });
    } catch (e) {
      print('에러 ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white100,
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
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: gray300, width: 1),
                              shape: BoxShape.circle),
                          child: ClipOval(
                            child: Image.network(
                              'https://i.namu.wiki/i/qEreAmFbCgPlrKxTyu3p1LPPO3H1PgPIY239AfhWa-qXbJITXTtxYziYFCJqFFwaFt174p5sHIXReL7TSUQ-oQ.webp',
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          child: GestureDetector(
                            child: SvgPicture.asset(svgsetimage,
                                width: 18, height: 18),
                          ),
                          left: 72,
                          top: 69,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 13),
                    child: Column(
                      children: [
                        Text(
                          userData != null ? '${userData!.name}' : '이름 로딩 중...',
                          style: semiBold16.copyWith(color: gray800),
                        ),
                        Text(
                          userData != null
                              ? '${userData!.studentNum}'
                              : '학생 번호 로딩 중...',
                          style: medium12.copyWith(color: gray600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이메일',
                      style: medium14.copyWith(color: gray800),
                    ),
                    ProfileText(
                        information: userData != null
                            ? '${userData!.email}'
                            : '이메일 로딩 중...')
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
                      style: medium14.copyWith(color: gray800),
                    ),
                    ProfileText(
                        information: userData != null
                            ? '${userData!.roomNum}'
                            : '호실 로딩 중...')
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LogoutModal();
                          });
                    },
                    child: Text(
                      '로그아웃',
                      style: regular14.copyWith(color: gray600),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
