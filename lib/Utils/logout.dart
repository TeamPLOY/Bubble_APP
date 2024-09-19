import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Logout{
  var access_token;
  var refresh_token;
  Logout(
    {
      required this.access_token,
      required this.refresh_token,
    }
  );

  Future<void> Logout_post() async{
    final String url = 'https://port-0-laundering-server-v1-9zxht12blq9gr7pi.sel4.cloudtype.app/logout';
    
    try{
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization':access_token
        }
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