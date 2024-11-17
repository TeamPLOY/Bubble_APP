import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bubble_app/data/models/notification_notification_model.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';

class NoticeNoticeApi {
  var access_token = globalTokens?.access_token;

  Future<List<NotificationNotificationModel>> fetnotification() async {
    final response = await http.get(
      Uri.parse(ApiUrls.notification_notification_url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${access_token}'
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      List<NotificationNotificationModel> Notification_result =
          jsonResponse.map((model) => NotificationNotificationModel.fromJson(model)).toList();
      return Notification_result;
    } else {
      print('실수 : ${response.body}');
      throw Exception('${response.statusCode}');
    }
  }
}
