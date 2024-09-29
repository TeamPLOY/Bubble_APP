import 'package:bubble_app/Utils/tokens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bubble_app/Models/reservation_state_model.dart';

class ReservationStateGet {
  var access_token=globalTokens?.access_token;
  String url =  'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/notification/history';
  Future<List<ReservationStateModel>> fetchreservation() async{
    final response = await http.get(Uri.parse(url),
    headers: <String,String>{
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer ${access_token}'
    },
    );

    if(response.statusCode==200){
      List jsonResponse =  jsonDecode(utf8.decode(response.bodyBytes));
      List<ReservationStateModel> reservation_state_result=jsonResponse.map((model)=>ReservationStateModel.fromJson(model)).toList();
      return reservation_state_result;
    }
    else{
      print('실수 : ${response.body}');
      throw Exception('${response.statusCode}');
    }
  }
}
