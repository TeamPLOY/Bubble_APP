import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';

class ReservationPostApi {
  final String date;
  final String machine;
  var access_token = globalTokens?.access_token ?? '';

  ReservationPostApi({required this.date,required this.machine});

  Future<void> reservationDate() async {
    Map<String, dynamic> postData = {
      // 'date': date.toIso8601String(),
      'date' : date,
      'machine':machine
    };

    try {
      final response = await http.post(
        Uri.parse(ApiUrls.reservation_post_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access_token',
        },
        body: jsonEncode(postData),
      );
      print('응답 상태: ${response.statusCode}');
      print('응답 본문: ${response.body}');
      if (response.statusCode == 204) {
        print('포스트 성공');
      } else {
        print('실패 :  ${response.statusCode}');
      }
    } catch (e) {
      print('에러 : $e');
    }
  }
}
