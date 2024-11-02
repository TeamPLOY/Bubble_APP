import 'package:bubble_app/Utils/api_urls.dart';
import 'package:bubble_app/Utils/tokens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bubble_app/Models/refresh_token_models.dart';


class RefreshPost {
  var refresh_token=globalTokens?.refresh_token;

  Future<void> get_tokens() async{
    
    try{
      final response = await http.post(
        Uri.parse(ApiUrls.refresh_post_url),
        headers: {
          'Content-Type': 'application/json',
          'refresh_token':'${refresh_token}'
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        RefreshTokenModels tokens = RefreshTokenModels.fromJson(responseData);
        globalTokens?.access_token=tokens.access_token;
        globalTokens?.refresh_token=tokens.refresh_token;
        if(globalTokens?.access_token==tokens.access_token || globalTokens?.refresh_token==tokens.refresh_token){
          print('포스트 성공 : $responseData');
        }
      } else {
         
        print('실패 :  ${response.statusCode}');
        print(response.body);
      }
    }
    catch(e){
      print("에러 ${e}");
    }
  }
}