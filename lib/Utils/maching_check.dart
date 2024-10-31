import 'package:bubble_app/Utils/tokens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MachingCheck {
  final String machine;
    var access_token = globalTokens?.access_token ?? '';

  MachingCheck({
    required this.machine,
  });
  
  Future<bool> checkpostData() async {
    Map<String, dynamic> postData = {
      'machine': machine,
    };
    
    final String url = 'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/notification/check';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer ${access_token}'
        },
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        bool state=responseData;
        print("check:${machine} : ${state}");
        return state;
      } else {
        print('실패 : ${response.statusCode}');
        print('실패 : ${response.body}');
        throw();
      }
    } catch (e) {
      print('에러 : $e');
      throw();
    }
  }
}