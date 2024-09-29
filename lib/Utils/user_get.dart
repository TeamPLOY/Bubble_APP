import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:bubble_app/Models/User.dart';

class UserGet {
  final String access_token;
  
  UserGet({required this.access_token});

  Future<User> fetchData() async {
    final String url = 'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/user'; 

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // HttpHeaders.authorizationHeader: '${access_token}',
          // // 'Authorization' : 'Bearer ${access_token},'
          'Authorization' : 'Bearer ${access_token}'
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(utf8.decode(response.bodyBytes));
        User userData = User.fromJson(responseData);
        print('Get 성공 name: ${userData.name}, studentNum: ${userData.studentNum}, email: ${userData.email}, roomNum: ${userData.roomNum}');
        return userData;
      } else {
        print('실패: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('에러: $e');
      throw Exception('Error fetching data: $e');
    }
  }
}
