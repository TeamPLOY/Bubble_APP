import 'package:http/http.dart' as http;

class CheckGet {
  Future<bool?> fetchData() async {
    final String url =
        'http://ec2-3-39-164-144.ap-northeast-2.compute.amazonaws.com:5000/isReserved';

    try {
      final response = await http.get(Uri.parse(url));

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
