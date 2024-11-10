import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';

class DeleteApi {
  final String email;
  final String passwrod;

  DeleteApi({required this.email,required this.passwrod});

  Future<bool> fetchData() async {
    var access_token = globalTokens?.access_token;
    globalTokens?.access_token = null;
    globalTokens?.refresh_token = null;
    Map<String, dynamic> postData = {
      'email': email,
      'password':passwrod
    };

    try {
      final response = await http.delete(
        Uri.parse(ApiUrls.delete_url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${access_token}'
        },
        body: jsonEncode(postData)
      );

      if (response.statusCode == 204) {
        print('포스트 성공');
        return true;
      } else {
        print('실패 :  ${response.statusCode}');
        print(response.body);
        return false;
      }
    } catch (e) {
      print('에러: $e');
      return false;
    }
  }
}