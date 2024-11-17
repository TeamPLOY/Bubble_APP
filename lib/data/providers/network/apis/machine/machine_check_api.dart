// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:bubble_app/data/providers/network/apis/api_url.dart';
// import 'package:bubble_app/data/providers/network/apis/token/token_api.dart';

// // 세탁기가 현재 작동 중인지 아닌지에 관한 api
// class MachingCheckApi {
//   final String machine;
//   var access_token = globalTokens?.access_token ?? '';

//   MachingCheckApi({
//     required this.machine,
//   });

//   Future<bool> checkpostData() async {
//     Map<String, dynamic> postData = {
//       'machine': machine,
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(ApiUrls.maching_check_url),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer ${access_token}'
//         },
//         body: jsonEncode(postData),
//       );
//       if (response.statusCode == 200) {
//         var responseData = jsonDecode(response.body);
//         bool state = responseData;
//         print("check:${machine} : ${state}");
//         return state;
//       } else {
//         print('실패 : ${response.statusCode}');
//         print('실패 : ${response.body}');
//         throw ();
//       }
//     } catch (e) {
//       print('에러 : $e');
//       throw ();
//     }
//   }
// }
