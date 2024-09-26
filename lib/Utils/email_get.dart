
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/Models/email_get_models.dart';

class Email_g{
  Future<EmailGetModels> fetchData() async{
    final String url = 'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/email';
    
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