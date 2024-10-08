import 'package:http/http.dart' as http;
import 'package:bubble_app/Utils/tokens.dart';


class Logout {
  Future<void> fetchData() async {
    final String url = 'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/logout';
    var access_token=globalTokens?.access_token;
    globalTokens?.access_token=null;
    globalTokens?.refresh_token=null;
     try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer ${access_token}'
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
