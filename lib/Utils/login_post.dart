import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/Models/token_models.dart';
class LoginPost {
  final String email;
  final String password;

  LoginPost({
    required this.email,
    required this.password,
  });

  Future<TokenModels> loginpostData() async {
    Map<String, dynamic> postData = {
      'email': email,
      'password': password,
    };
    
    final String url = 'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/login';
    
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var tokens = responseData['tokens'];
        
        var accessToken = tokens['accessToken'];
        var refreshToken = tokens['refreshToken'];
        TokenModels Token = TokenModels(access_token: accessToken, refresh_token: refreshToken);

        //print('포스트 성공');
        return Token;
      } else {
        print('실패 : ${response.statusCode}');
        return TokenModels(access_token: null, refresh_token: null);
      }
    } catch (e) {
      print('에러 : $e');
      return TokenModels(access_token: null, refresh_token: null);
    }
  }
}