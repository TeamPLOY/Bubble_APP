import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bubble_app/data/models/notice_model.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';

class NoticeApi {
  var access_token = globalTokens?.access_token;

  Future<List<Noticemodel>> fetchNotice() async {
    final response = await http.get(
      Uri.parse(ApiUrls.notification_url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${access_token}'
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      List<Noticemodel> Notification_result =
          jsonResponse.map((model) => Noticemodel.fromJson(model)).toList();
      return Notification_result;
    } else {
      print('실수 : ${response.body}');
      throw Exception('${response.statusCode}');
    }
  }
}
