import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/data/models/email_get_model.dart';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';

class EmailGetApi {
  Future<EmailGetModel> fetchData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.email_get_url));

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        EmailGetModel emailGetModels = EmailGetModel.fromJson(responseData);
        print(
            'Get 성공 code : ${emailGetModels.code}, email : ${emailGetModels.email} ');
        return emailGetModels;
      } else {
        print('실패 :  ${response.statusCode}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('에러 : $e');
      throw Exception('Error fetching data: $e');
    }
  }
}
