import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Join {
  late String email;
  final String password;
  final String name;
  final int stuNum;
  final String roomNum;

  
  Join({
    required this.email,
    required this.password,
    required this.name,
    required this.stuNum,
    required this.roomNum,
  });

  Future<void> joinpostData() async {
    Map<String, dynamic> postData= {
      'email': email,
      'password': password,
      'name': name,
      'stuNum': stuNum,
      'roomNum': roomNum,
    };
    
    print(email);
    print(password);
    print(name);
    print(stuNum);
    print(roomNum);

    final String url = 'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/signup';
    
    try{
      final response = await http.post(
        Uri.parse(url),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(postData),
      );
      print('응답 상태: ${response.statusCode}');
      print('응답 본문: ${response.body}');
      if(response.statusCode == 200){
        var responseData = response.body;
        print('포스트 성공 : $responseData');
      }

      else{
        print('실패 :  ${response.statusCode}');
      }
    }
    catch(e){
      print('에러 : $e');
    }
  }
}

