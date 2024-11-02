import 'package:bubble_app/Utils/api_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bubble_app/Models/reservation_models.dart';
import 'package:bubble_app/Utils/tokens.dart';

class ReservationGet {
  var access_token = globalTokens?.access_token ?? '';

  Future<List<ReservationModels>> fetchData() async {

    try {
      final response = await http.get(
        Uri.parse(ApiUrls.reservation_get_url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $access_token',
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(utf8.decode(response.bodyBytes));

        if (responseData is List) {
          return responseData
              .map((machine) => ReservationModels.fromJson(machine))
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
