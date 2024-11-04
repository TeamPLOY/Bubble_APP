import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bubble_app/data/models/user_model.dart';
import 'package:bubble_app/data/providers/network/apis/api_url.dart';

class ProfileApi {
  final String access_token;

  ProfileApi({required this.access_token});

  Future<UserModel> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.user_get_url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${access_token}'
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(utf8.decode(response.bodyBytes));
        UserModel userData = UserModel.fromJson(responseData);
        print(
            'Get 성공 name: ${userData.name}, studentNum: ${userData.studentNum}, email: ${userData.email}, roomNum: ${userData.roomNum}');
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
