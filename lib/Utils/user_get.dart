import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bubble_app/Models/User.dart';

class UserGet{
  Future<User> fetchData() async{
    
    final String url = 'https://port-0-laundering-server-v1-9zxht12blq9gr7pi.sel4.cloudtype.app/user';
    
    try{
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        }
      );
      
      
      if(response.statusCode == 200){
        var responseData = jsonDecode(response.body);
        User Userdata = User.fromJson(responseData);
        print('Get 성공 name : ${Userdata.name}, studentNum : ${Userdata.studentNum},email : ${Userdata.email},roomNum : ${Userdata.roomNum},');
        return Userdata;
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