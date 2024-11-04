import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bubble_app/data/models/machine_model.dart';
import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';

class MachineGetApi {
  var access_token = globalTokens?.access_token ?? '';

  Future<List<MachineModel>> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.machine_get_url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${access_token}'
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(utf8.decode(response.bodyBytes));

        if (responseData is List) {
          return responseData
              .map((machine) => MachineModel.fromJson(machine))
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
