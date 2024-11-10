import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';

class ReservationCancelApi {
  late String date;
  var access_token = globalTokens?.access_token;
  ReservationCancelApi({required this.date});
  String formatDate(String dateString) {
    final date = DateTime.parse(
      dateString.replaceAll('년 ', '-').replaceAll('월 ', '-').replaceAll('일', '')
    );

    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
  Future<void> fetchCancel() async {
    String dateTime=formatDate(date);
    Map<String, dynamic> postData = {
      'date': dateTime,
    };
    print(date);

    try {
      final response = await http.post(
        Uri.parse(ApiUrls.cancel_post_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${access_token}'
        },
        body: jsonEncode(postData),
      );
      print('응답 상태: ${response.statusCode}');
      print('응답 본문: ${response.body}');
      if (response.statusCode == 204) {
        var responseData = response.body;
        print('포스트 성공 : $responseData');
      } else {
        print('실패 :  ${response.statusCode}');
      }
    } catch (e) {
      print('에러 : $e');
    }
  }
}
