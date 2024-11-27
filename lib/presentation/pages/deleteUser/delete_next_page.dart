import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/data/providers/network/apis/login/logout_api.dart';
// import 'package:bubble_app/presentation/pages/profile/profile_page.dart';
import 'package:bubble_app/presentation/widgets/button/next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bubble_app/presentation/pages/onboarding/onboarding_page.dart';

class DeleteNextPage extends StatelessWidget {
  DeleteNextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                  'assets/img/finish.svg',
                  width: 100,
                  height: 100,
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Text('회원 탈퇴가 완료되었습니다.',style: AppTextStyles.bold20.copyWith(color: AppColor.gray700,)),
              SizedBox(height: 4,),
              Text('그동안 BUBBLE을 이용해주셔서 감사합니다.',style: AppTextStyles.regular14.copyWith(color: AppColor.gray700),),
              SizedBox(height: 25,),
              GestureDetector(
                onTap: (){
                  LogoutApi logout = LogoutApi();
                  logout.fetchData();
                  Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                            (context, animation, secondaryAnimation) =>
                            OnboardingPage(),
                            transitionsBuilder: (context, animation,
                            secondaryAnimation, child) {
                            return child; // 애니메이션 없이 바로 화면 전환
                        },
                        ),
                      );
                },
                child: NextButton(text: '확인', onPressed: (){}))
            ],
            
          )
        ],
      ),
    );
  }
}