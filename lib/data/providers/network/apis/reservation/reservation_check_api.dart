import 'package:http/http.dart' as http;
import 'package:bubble_app/data/providers/network/apis/api_url.dart';

class ReservationCheckApi {
  Future<bool?> fetchData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.check_get_url));

      print('서버 응답: ${response.body}');

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('에러: $e');
      throw Exception('데이터를 가져오는 중 오류 발생: $e');
    }
  }
}
