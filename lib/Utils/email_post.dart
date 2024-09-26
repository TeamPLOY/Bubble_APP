
import 'package:http/http.dart' as http;
import 'dart:convert';

class Email_p{
  late String email;

  Email_p({required this.email});

  Future<void> emailData_post() async{
    Map<String, dynamic> postData= {
      'email': email,
    };

    final String url = 'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/email';

    try{
      final response = await http.post(
        Uri.parse(url),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(postData),
      );
      print('응답 상태: ${response.statusCode}');
      print('응답 본문: ${response.body}');
      if(response.statusCode == 204){
        var responseData = response.body;
        print('포스트 성공 : $responseData');
      }

      else{
        print('실패 :  ${response.statusCode}');
      }
    }
    catch(e){
      print('에러 : $e');
    }
  }
}