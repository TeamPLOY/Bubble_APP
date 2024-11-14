import 'package:bubble_app/data/Functions/deletesearch.dart';
import 'package:bubble_app/presentation/pages/deleteUser/delete_next_page.dart';
import 'package:bubble_app/presentation/widgets/box/input_box.dart';
import 'package:bubble_app/presentation/widgets/button/next_button.dart';
import 'package:bubble_app/presentation/widgets/text/input_title.dart';
import 'package:bubble_app/presentation/widgets/text/message.dart';
import 'package:flutter/material.dart';
import 'package:bubble_app/app/config/app_color.dart';
import 'package:bubble_app/app/config/app_text_styles.dart';
import 'package:bubble_app/presentation/widgets/header/side_header.dart';
import 'package:bubble_app/data/providers/network/apis/delete/delete_api.dart';

class DelPage extends StatefulWidget {
  const DelPage({super.key});

  @override
  State<DelPage> createState() => _DeletePageState();
}
 
class _DeletePageState extends State<DelPage> {
  List<bool> validationemailResults = [false, false,false];

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController repasswordController = TextEditingController();

  late bool delete_state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideHeader(text: "탈퇴하기"),
          SizedBox(height: MediaQuery.of(context).size.height*(100/852),),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('회원 탈퇴를 위해',style: AppTextStyles.bold20.copyWith(color: AppColor.gray700),),
                Text('회원정보를 입력해주세요.',style: AppTextStyles.bold20.copyWith(color: AppColor.gray700),),
                SizedBox(height: 17,),

                InputTitle(text: '이메일'),
                Inputbox(wsize: 347, hsize: 40, text: "이메일을 입력해주세요", controller: emailController),
                validationemailResults[2]==true? Message(text: "이메일을 제대로 입력해주세요."):SizedBox(height: 0,width: 0,),
                SizedBox(height: 8,),

                InputTitle(text: '비밀번호'),
                Inputbox(password: true,wsize: 347, hsize: 40, text: "비밀번호를 입력해주세요", controller: passwordController),
                validationemailResults[0]==true? Message(text: "비밀번호를 제대로 입력해주세요."):SizedBox(height: 0,width: 0,),
                const SizedBox(height: 8,),
                InputTitle(text: '비밀번호 확인'),

                Inputbox(password: true,wsize: 347, hsize: 40, text: "비밀번호를 다시 입력해주세요", controller: repasswordController),
                validationemailResults[1]==true? Message(text: "비밀번호가 일치하지 않습니다."):SizedBox(height: 0,width: 0,),
                SizedBox(height: 17,),

                GestureDetector(
                  onTap: () async{
                    Deletesearch formsearch = Deletesearch(
                              emailController: emailController,
                              passwordController: passwordController,
                              repasswordController: repasswordController,
                    );
                    setState(() {
                      validationemailResults=formsearch.checkForm();
                    });
                    if(validationemailResults[0]==false&&validationemailResults[1]==false&&validationemailResults[2]==false){
                      DeleteApi deleteApi = DeleteApi(email: emailController.text,passwrod: passwordController.text);
                      delete_state= await deleteApi.fetchData();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                            (context, animation, secondaryAnimation) =>
                              DeleteNextPage(state: delete_state,),
                            transitionsBuilder: (context, animation,
                            secondaryAnimation, child) {
                            return child; // 애니메이션 없이 바로 화면 전환
                        },
                        ),
                      );
                    }
                  },
                  child: NextButton(text: "탈퇴하기", onPressed: (){}))
              ],
            ),
          )
        ],
      ),
    );
  }
}