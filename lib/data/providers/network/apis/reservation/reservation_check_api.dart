import 'package:http/http.dart' as http;
import 'package:bubble_app/data/providers/network/apis/api_url.dart';
import 'dart:convert';
import 'dart:async';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/models/reservation_check_model.dart';

class ReservationCheckApi {
  var access_token = globalTokens?.access_token ?? '';

  Future<bool> fetchData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.check_get_url),headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $access_token',
      });

      if (response.statusCode == 200) {
        var responseData = jsonDecode(utf8.decode(response.bodyBytes));
        ReservationCheckModel reservationCheckModel = ReservationCheckModel(isChecked: responseData);
        return reservationCheckModel.isChecked;
        
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('에러: $e');
      throw Exception('데이터를 가져오는 중 오류 발생: $e');
    }
  }
}