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
  List<bool> validationemailResults = [false, false, false];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  late bool delete_state;

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              double screenHeight = constraints.maxHeight;

              double titleFontSize = screenWidth > 393 ? 20 : 18;
              double contentFontSize = screenWidth > 393 ? 18 : 16;

              return Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColor.white100
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04, 
                  vertical: screenHeight * 0.03
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '회원 탈퇴',
                      style: AppTextStyles.bold18.copyWith(
                        color: AppColor.gray800, 
                        fontSize: titleFontSize
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      '회원 탈퇴 시 계정 정보가 삭제되어 복구가 불가해요.',
                      style: AppTextStyles.regular18.copyWith(
                        color: AppColor.gray600, 
                        fontSize: contentFontSize
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      '정말로 탈퇴하시겠어요?',
                      style: AppTextStyles.regular18.copyWith(
                        color: AppColor.gray600, 
                        fontSize: contentFontSize
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.gray200,
                              ),
                              child: Center(
                                child: Text(
                                  '더 써볼래요',
                                  style: AppTextStyles.regular18.copyWith(
                                    color: AppColor.gray700,
                                    fontSize: contentFontSize,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (validationemailResults[0] == false &&
                                  validationemailResults[1] == false &&
                                  validationemailResults[2] == false) {
                                DeleteApi deleteApi = DeleteApi(
                                  email: emailController.text,
                                  passwrod: passwordController.text,
                                );
                                delete_state = await deleteApi.fetchData();
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        DeleteNextPage(state: delete_state),
                                    transitionsBuilder:
                                        (context, animation, secondaryAnimation, child) {
                                      return child;
                                    },
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.blue400,
                              ),
                              child: Center(
                                child: Text(
                                  '떠날래요',
                                  style: AppTextStyles.regular18.copyWith(
                                    color: AppColor.white100,
                                    fontSize: contentFontSize,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideHeader(text: "탈퇴하기"),
          SizedBox(
            height: MediaQuery.of(context).size.height * (100 / 852),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '회원 탈퇴를 위해\n회원정보를 입력해주세요.',
                  style: AppTextStyles.bold20.copyWith(color: AppColor.gray700),
                ),
                const SizedBox(height: 17),
                InputTitle(text: '이메일'),
                Inputbox(
                  wsize: 347,
                  hsize: 40,
                  text: "이메일을 입력해주세요",
                  controller: emailController,
                ),
                validationemailResults[2]
                    ? Message(text: "이메일을 제대로 입력해주세요.")
                    : const SizedBox(height: 0, width: 0),
                const SizedBox(height: 8),
                InputTitle(text: '비밀번호'),
                Inputbox(
                  password: true,
                  wsize: 347,
                  hsize: 40,
                  text: "비밀번호를 입력해주세요",
                  controller: passwordController,
                ),
                validationemailResults[0]
                    ? Message(text: "비밀번호를 제대로 입력해주세요.")
                    : const SizedBox(height: 0, width: 0),
                const SizedBox(height: 8),
                InputTitle(text: '비밀번호 확인'),
                Inputbox(
                  password: true,
                  wsize: 347,
                  hsize: 40,
                  text: "비밀번호를 다시 입력해주세요",
                  controller: repasswordController,
                ),
                validationemailResults[1]
                    ? Message(text: "비밀번호가 일치하지 않습니다.")
                    : const SizedBox(height: 0, width: 0),
                const SizedBox(height: 17),
                GestureDetector(
                  onTap: () async {
                    Deletesearch formsearch = Deletesearch(
                      emailController: emailController,
                      passwordController: passwordController,
                      repasswordController: repasswordController,
                    );
                    setState(() {
                      validationemailResults = formsearch.checkForm();
                    });
                    
                    if (validationemailResults[0] == false &&
                        validationemailResults[1] == false &&
                        validationemailResults[2] == false) {
                      _showDeleteDialog();
                    }
                  },
                  child: NextButton(
                    text: "탈퇴하기",
                    onPressed: () {},
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