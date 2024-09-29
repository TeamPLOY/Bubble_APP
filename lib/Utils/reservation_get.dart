import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:bubble_app/Models/reservation_models.dart';
import 'package:bubble_app/Utils/tokens.dart';

class ReservationGet {
  var access_token = globalTokens?.access_token ?? '';

  Future<List<Reservation>> fetchData() async {
    final String url =
        "http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/reservation";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $access_token',
        },
      );

      if (response.statusCode == 200) {
        print("윤서왔당");
        var responseData = jsonDecode(utf8.decode(response.bodyBytes));

        if (responseData is List) {
          return responseData
              .map((machine) => Reservation.fromJson(machine))
              .toList();
        } else {
          throw Exception('응답이 리스트가 아닙니다.');
        }
      } else {
        print('실패 : ${response.statusCode}');
        throw Exception('Fasd: ${response.body}');
      }
    } catch (e) {
      print('에러 : $e');
      throw Exception('Error fetching data: $e');
    }
  }
}
