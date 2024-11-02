
import 'package:bubble_app/Utils/api_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Email_p{
  late String email;

  Email_p({required this.email});

  Future<void> emailData_post() async{
    Map<String, dynamic> postData= {
      'email': email,
    };

    try{
      final response = await http.post(
        Uri.parse(ApiUrls.email_post_url),
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