import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/Models/email_get_models.dart';

class Email_g{
  Future<EmailGetModels> fetchData() async{
    final String url = 'https://port-0-laundering-server-v1-9zxht12blq9gr7pi.sel4.cloudtype.app/email';
    
    try{
      final response = await http.get(Uri.parse(url));
      
      if(response.statusCode == 200){
        var responseData = jsonDecode(response.body);
        EmailGetModels emailGetModels = EmailGetModels.fromJson(responseData);
        print('Get 성공 code : ${emailGetModels.code}, email : ${emailGetModels.email} ');
        return emailGetModels;
      }

      else{
        print('실패 :  ${response.statusCode}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    }
    catch(e){
      print('에러 : $e');
      throw Exception('Error fetching data: $e');
    }
  }
}