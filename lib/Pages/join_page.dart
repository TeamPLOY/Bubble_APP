import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bubble_app/components/header/header.dart';
import 'package:bubble_app/Functions/emailsearch.dart';
import 'package:bubble_app/theme.dart';
import 'package:bubble_app/components/box/start_print.dart';
import 'package:bubble_app/components/box/inputbox.dart';
import 'package:bubble_app/components/box/dropdownbox.dart';
import 'package:bubble_app/components/button/reservationButton.dart';
import 'package:bubble_app/Functions/UnderlinedText.dart';
import 'package:bubble_app/Functions/Formsearch.dart';
import 'package:bubble_app/components/box/searchText.dart';
import 'package:bubble_app/pages/Terms_Use.dart';
import 'package:bubble_app/Utils/join.dart';
import 'package:bubble_app/Utils/email_post.dart';
import 'package:bubble_app/Models/email_checkmodels.dart';
import 'package:bubble_app/Utils/email_check.dart';

class JoinPage extends StatefulWidget {
  JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  List<bool> validationResults=[false,false,false,false];
  List<bool> validationemailResults=[false,false];

  String? selectedgrade;
  String? selectedclass_number;
  String? selectedstudent_number;
  String? selectedroom;

  bool submitstate=false;

  List<String> grade= ['1학년','2학년','3학년'];
  List<String> room= ['A동','B동'];
  List<String> class_number= ['1반','2반','3반','4반'];
  List<String> student_number= ['1번','2번','3번','4번','5번','6번','7번','8번','9번','10번','11번','12번','13번','14번','15번','16번',];
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController comController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController BufferController = TextEditingController();
  
  static const int Fiveminute=300;
  int totalSecond = Fiveminute;
  bool inRunining =false;
  int totalp=0;
  bool said_email=false;
  late Timer timer;
  late int gradenumber;
  late String emails;
  //late EmailGetModels email_checkCode;
  bool openstate=false;

  String format(int seconds){
    var duration = Duration(seconds: seconds);

    return duration.toString().split(".").first.substring(2,7);
  }

  void onStatePressed() {

    if (inRunining) {
      timer.cancel();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      onTick(timer);
    });

    setState(() {
      inRunining = true;
      totalSecond = Fiveminute;
    });
  }

  void onTick(Timer timer) {
    if (totalSecond == 0) {
      setState(() {
        totalp = totalp + 1;
        submitstate = false;
        timer.cancel();
        inRunining = false;
      });
    } else {
      setState(() {
        totalSecond = totalSecond - 1;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    selectedclass_number=class_number.first;
    selectedgrade=grade.first;
    selectedstudent_number=student_number.first;
    selectedroom=room.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:[ Column(
          children: [
            Header(text: '회원가입'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * (24 / 393)),
              child: Padding(
                padding: const EdgeInsets.only(top: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('반가워요!', style: bold20.copyWith(color: gray700)),
                    Text('회원정보를 입력해주세요.', style: bold20.copyWith(color: gray700)),
                    Text('원활한 서비스 제공을 위해 회원정보가 사용됩니다.', style: medium14.copyWith(color: gray600)),
                    SizedBox(height: 23),
                    StartPrint(text: '이메일'),
                    Row(
                      children: [ 
                        Inputbox(wsize: 121, hsize: 40, text: '이메일', controller: emailController),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text('@', style: medium14.copyWith(color: gray600)),
                        ),
                        Inputbox(wsize: 98, hsize: 40, text: 'bssm.hs.kr', controller: comController),
                        SizedBox(width:10),
                        Expanded(
                          child: InkWell(
                            splashColor: blue900,
                            borderRadius: BorderRadius.circular(5),
                            highlightColor: blue700,
                            splashFactory: InkRipple.splashFactory,
                            child: GestureDetector(
                              onTap: () async{
                                Emailsearch emailsearch = Emailsearch(
                                  comController: comController,
                                  emailController: emailController,
                                );
                                emails = emailController.text + '@bssm.hs.kr';
                                validationemailResults = emailsearch.checkForm();
                                
                                if(openstate==false){
                                  if (!submitstate) {
                                      onStatePressed();
                                      setState(() {
                                        submitstate = true;
                                    });
                                  }
                                  if (validationemailResults.every((element) => element == false)) {
                                    if (BufferController.text.length == 6) {
                                      final int code = int.parse(BufferController.text);
                                      EmailCheck emailCheck = EmailCheck(code: code, email: emails);
                                      bool emailstate = await emailCheck.emailData_post();
                                      setState(() {
                                        if (emailstate) {
                                          submitstate = false;
                                          print('인증 성공 : $emailstate');
                                          openstate=true;
                                          said_email=false;
                                        } else {
                                          print('인증 실패');
                                        }
                                      });
                                    } else {
                                      Email_p email_post = Email_p(email: emails);
                                      email_post.emailData_post();
                                    }
                                    
                                  }
                                }
                              }, 
                              child: Container(
                                decoration: BoxDecoration(
                                  color: blue400,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: MediaQuery.of(context).size.width * (95 / 393),
                                height: 40,
                                child: Center(
                                  child: Text('인증하기', style: semiBold14.copyWith(color: gray100)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if(validationemailResults[0]==true || validationemailResults[1]==true)
                    const Searchtext(text: '이메일을 정확히 입력하세요.'),
                    if(said_email==true)
                    const Searchtext(text: '이메일을 인증을 받지않았습니다.'),
                    
                    if(submitstate==true)
                      Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        children: [
                          Inputbox(wsize: 345, hsize: 40, text: '인증번호 6자리', controller: BufferController),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: UnderlinedText(text:'재전송'),
                                onTap: () {
                                  if(emails!=null){
                                    Email_p email_post = Email_p(email: emails);
                                    email_post.emailData_post();
                                  }
                                  setState(() {
                                    totalSecond=Fiveminute;
                                  });
                                },
                              ),
                              Text('${format(totalSecond)}',style: medium12.copyWith(color: red100),)
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const StartPrint(text: '비밀번호'),
                    Inputbox(wsize: 393-48, hsize: 40, text: '6자 이상, 특수문자를 포함해 작성해주세요.', controller: passwordController,password: true,),
                    if(validationResults[0]==true)const Searchtext(text: '비밀번호가 너무 짧습니다.'),
                    const SizedBox(height: 20,),
                    const StartPrint(text: '비밀번호 확인'),
                    Inputbox(wsize: 393-48, hsize: 40, text: '비밀번호를 다시 입력해주세요.', controller: repasswordController,password: true),
                    if(validationResults[3]==true)const Searchtext(text: '비밀번호가 틀렸습니다.'),
                    const SizedBox(height: 20,),
                    const StartPrint(text: '이름'),
                    Inputbox(wsize: 393-48, hsize:40, text: '이름을 입력해주세요.', controller: nameController),
                    if(validationResults[1]==true)const Searchtext(text: '이름을 정확히 입력하세요.'),
                    const SizedBox(height: 20,),
                    const StartPrint(text: '학번'),
                    Row(
                      children: [
                        Dropdownbox(hsize: 40,wsize: 110,index_list: grade,onChanged: (String? value){setState((){selectedgrade=value;});print('${selectedgrade}');},),
                        SizedBox(width: 8,),
                        Dropdownbox(hsize: 40,wsize: 110,index_list: class_number,onChanged: (String? value){setState((){selectedclass_number=value;});print('${selectedclass_number}');},),
                        SizedBox(width: 8,),
                        Expanded(child: Dropdownbox(hsize: 40,wsize: 110,index_list: student_number,onChanged: (String? value){setState((){selectedstudent_number=value;});print('${selectedstudent_number}');},)),
                      ],
                    ),
                    SizedBox(height: 20,),
                    StartPrint(text: '기숙사 호실'),
                    Row(
                      children: [
                        Dropdownbox(hsize: 40,wsize: 110,index_list: room,onChanged: (String? value){setState((){selectedroom=value;});print('${selectedroom}');},),
                        SizedBox(width: 7,),
                        Expanded(child: Inputbox(wsize: 227, hsize: 40, text: '호실을 입력해주세요', controller: roomController))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if(validationResults[2]==true)const Searchtext(text: '호실을 정확히 입력하세요.'),
                      ],
                    ),
                    
                    SizedBox(height: 66,),
                    Align(child: Text('빈 칸을 모두 작성해주세요',style: medium12.copyWith(color: red100),)),
                    SizedBox(height: 2,),
                    GestureDetector(
                      onTap: (){Formsearch formsearch = Formsearch(
                        nameController:nameController,
                        passwordController: passwordController,
                        repasswordController: repasswordController,
                        roomController: roomController,
                      );
                      setState(() {
                        validationResults = formsearch.checkForm();
                      });
                      print(validationResults);
                      if(openstate==false){
                        said_email=true;
                      }
                      if(validationResults.every((element)=>element==false) && openstate==true){
                        gradenumber=(selectedgrade!=null ? int.parse(selectedgrade![0]):1 )*1000;
                        gradenumber=gradenumber+(selectedclass_number!=null ? int.parse(selectedclass_number![0]):1 )*100;
                        if(selectedstudent_number![1]=="번"){
                          gradenumber=gradenumber+(selectedstudent_number!=null ? int.parse(selectedstudent_number![0]):1);
                        }
                        else{
                          gradenumber=gradenumber+(selectedstudent_number!=null ? int.parse(selectedstudent_number![1]):1);
                          gradenumber=gradenumber+(selectedstudent_number!=null ? int.parse(selectedstudent_number![0]):1)*10;
                        }

                        if (emails == null) {
                          print("이메일을 입력하세요.");
                          return;
                        }
                        String room_number =selectedroom![0]+roomController.text;
                        Join join = Join(email: emails!, password: passwordController.text, name: nameController.text, stuNum:gradenumber, roomNum: room_number);
                        
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => TermsUse(joins: join,),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return child; // 애니메이션 없이 바로 화면 전환
                            },
                          ),
                        );
                      }
                      },
                      child: Reservationbutton()
                    ),
                    SizedBox(height: 58,)
                  ],
                ),
              ),
            ),
          ],
        ),
        ]
      ),
    );
  }
}