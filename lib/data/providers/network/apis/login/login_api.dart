import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/data/models/token_model.dart';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';
import 'package:bubble_app/data/providers/network/security_storage.dart';

class LoginApi {
  final String email;
  final String password;

  LoginApi({
    required this.email,
    required this.password,
  });
  Future<TokenModel> loginpostData() async {
    Map<String, dynamic> postData = {
      'email': email,
      'password': password,
    };

    try {
      print('서버에 전송할 데이터: $postData');
      final response = await http.post(
        Uri.parse(ApiUrls.login_post_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var tokens = responseData['tokens'];

        var accessToken = tokens['accessToken'];
        var refreshToken = tokens['refreshToken'];
        SecurityStorage storage = SecurityStorage();
        await storage.clearUserData();
        await storage.saveSecureToken('accessToken', accessToken);
        await storage.saveSecureToken('refreshToken', refreshToken);
        
        TokenModel token =TokenModel(access_token: accessToken, refresh_token: refreshToken);

        return token;
      } else {
        print('실패 : ${response.statusCode}');
        return TokenModel(access_token: null, refresh_token: null);
      }
    } catch (e) {
      print('에러 : $e');
      return TokenModel(access_token: null, refresh_token: null);
    }
  }
}
