import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/models/refresh_token_model.dart';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';
import 'package:bubble_app/data/providers/network/security_storage.dart';

class RefreshApi {
  Future<void> get_tokens() async {
    SecurityStorage storage =SecurityStorage();

    var refresh_tokens =await storage.readSecureToken('refreshToken');
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.refresh_post_url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: {
          jsonEncode(refresh_tokens)
        }
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        RefreshTokenModel tokens = RefreshTokenModel.fromJson(responseData);
        globalTokens?.access_token = tokens.access_token;
        globalTokens?.refresh_token = tokens.refresh_token;
        await storage.clearUserData();
        await storage.saveSecureToken('accessToken', tokens.access_token);
        await storage.saveSecureToken('refreshToken', tokens.refresh_token);

        if (globalTokens?.access_token == tokens.access_token ||
            globalTokens?.refresh_token == tokens.refresh_token) {
          print('포스트 성공 : $responseData');
        }
      } else {
        print('실패 :  ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print("에러 ${e}");
    }
  }
}
