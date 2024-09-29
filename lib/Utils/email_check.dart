
import 'package:http/http.dart' as http;
import 'dart:convert';


class EmailCheck{
  late int code;
  late String email;

  EmailCheck({required this.code ,required this.email});

  Future<bool> emailData_post() async{
    Map<String, dynamic> postData= {
      "code" : code,
      'email': email,
    };

    //print(code);
    //print(code.runtimeType);

    final String url = 'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/email/check';
    
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
      if(response.statusCode == 200){
        var responseData = jsonDecode(response.body);
        //print('포스트 성공 : $responseData');
        // EmailCheckmodels emailCheckmodels = EmailCheckmodels.fromJson(responseData);
        // bool emailcheck=emailCheckmodels.check;
        return responseData;
      }

      else{
        print('실패 :  ${response.statusCode}');
        throw Exception('Failed to load data: ${response.statusCode}'); 
      }
    }
    catch(e){
      print('에러 : $e');
      throw Exception('Error occurred: $e');
    }
  }
}