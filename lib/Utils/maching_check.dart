import 'package:bubble_app/Utils/api_urls.dart';
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

    try {
      final response = await http.post(
        Uri.parse(ApiUrls.maching_check_url),
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