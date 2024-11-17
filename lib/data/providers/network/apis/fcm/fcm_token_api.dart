import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';

class FcmTokenApi {
  final String fcmtoken;

  FcmTokenApi({
    required this.fcmtoken,
  });

  Future<bool> fcmTokenData() async {
    Map<String, dynamic> postData = {
      'token': fcmtoken,
    };

    try {
      print('서버에 전송할 데이터: $postData');

      final response = await http.post(
        Uri.parse(ApiUrls.maching_save_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${globalTokens?.access_token}',
        },
        body: jsonEncode(postData),
      );

      print('서버 응답 코드: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('FCM 토큰 저장 성공');
        return true;
      } else {
        print('FCM 토큰 저장 실패: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('FCM 토큰 저장 중 오류 발생: $e');
      return false;
    }
  }
}
