import 'package:bubble_app/Utils/api_urls.dart';
import 'package:bubble_app/Utils/tokens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MachineSave {
  final String machine;
    var access_token = globalTokens?.access_token ?? '';

  MachineSave({
    required this.machine,
  });

  Future<void> savepostData() async {
    Map<String, dynamic> postData = {
      'machine': machine,
    };
    try {
      print(machine);
      final response = await http.post(
        Uri.parse(ApiUrls.maching_save_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer ${access_token}'
        },
        body: jsonEncode(postData),
      );
      if (response.statusCode == 204) {
        // print(response.body);
      } else {
        print('실패 : ${response.statusCode}');
      }
    } catch (e) {
      print('에러 : $e');
    }
  }
}