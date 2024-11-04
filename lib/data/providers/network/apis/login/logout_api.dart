import 'package:http/http.dart' as http;
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';

class LogoutApi {
  Future<void> fetchData() async {
    var access_token = globalTokens?.access_token;
    globalTokens?.access_token = null;
    globalTokens?.refresh_token = null;
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.logout_url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${access_token}'
        },
      );

      if (response.statusCode == 204) {
        // var responseData = jsonDecode(response.body);
        print('포스트 성공');
      } else {
        print('실패 :  ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('에러: $e');
    }
  }
}
