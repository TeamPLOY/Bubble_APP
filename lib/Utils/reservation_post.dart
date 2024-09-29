import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/Utils/tokens.dart';

class ReservationPost {
  late DateTime date;
  var access_token = globalTokens?.access_token ?? '';

  ReservationPost({required this.date});

  Future<void> reservationDate() async {
    Map<String, dynamic> postData = {
      'date': date.toIso8601String(),
    };

    final String url =
        'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/reservation';

    try {
      final response = await http.post(
        Uri.parse(url),
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
