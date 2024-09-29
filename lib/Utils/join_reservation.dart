import 'dart:convert';  // JSON 변환을 위해 필요
import 'package:http/http.dart' as http;
import 'package:bubble_app/Models/reservation_models.dart';
import 'package:bubble_app/Utils/tokens.dart';

class JoinReservation {
  var access_token=globalTokens?.access_token;
  String url =  'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/reservation';
  Future<List<ReservationModels>> fetchReservation() async{
    final response = await http.get(Uri.parse(url),
    headers: <String,String>{
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer ${access_token}'
    },
    );

    if(response.statusCode==200){
      List jsonResponse =  jsonDecode(utf8.decode(response.bodyBytes));
      List<ReservationModels> reservation_result=jsonResponse.map((model)=>ReservationModels.fromJson(model)).toList();
      return reservation_result;
    }
    else{
      print('실수 : ${response.body}');
      throw Exception('${response.statusCode}');
    }
  }
}