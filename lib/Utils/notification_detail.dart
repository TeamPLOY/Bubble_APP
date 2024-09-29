import 'dart:convert';  // JSON 변환을 위해 필요
import 'package:http/http.dart' as http;
import 'package:bubble_app/Models/notification_detail_models.dart';
import 'package:bubble_app/Utils/tokens.dart';

class NotificationDetail_get {
  var access_token=globalTokens?.access_token;
  String url =  'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/notification/detail';
  Future<List<NotificationDetailModels>> fetchNotificationDetail() async{
    final response = await http.get(Uri.parse(url),
    headers: <String,String>{
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer ${access_token}'
    },
    );

    if(response.statusCode==200){
      List jsonResponse =  jsonDecode(utf8.decode(response.bodyBytes));
      List<NotificationDetailModels> Notification_result=jsonResponse.map((model)=>NotificationDetailModels.fromJson(model)).toList();
      return Notification_result;
    }
    else{
      print('실수 : ${response.body}');
      throw Exception('${response.statusCode}');
    }
  }
}