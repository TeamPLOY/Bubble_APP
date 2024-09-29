import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/Utils/tokens.dart';

class CancelPost {
  late String date;
  var access_token=globalTokens?.access_token;
  CancelPost({required this.date});

  Future<void> fetchCancel() async{
    Map<String, dynamic> postData= {
      'date': date,
    };

    final String url = 'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/reservation/cancel';

    try{
      final response = await http.post(
        Uri.parse(url),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer ${access_token}'
        },
        body: jsonEncode(postData),
      );
      print('응답 상태: ${response.statusCode}');
      print('응답 본문: ${response.body}');
      if(response.statusCode == 200){
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
