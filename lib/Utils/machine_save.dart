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
    final String url = 'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/notification/save';
    try {
      print(machine);
      final response = await http.post(
        Uri.parse(url),
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