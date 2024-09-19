class EmailCheckmodels {
  final bool check;

  // 생성자
  EmailCheckmodels({
    required this.check,
  });

  // JSON 데이터를 객체로 변환하는 fromJson 메서드
  factory EmailCheckmodels.fromJson(Map<String, dynamic> json) {
    return EmailCheckmodels(
      check: json['check'], // JSON에서 'check' 값을 받아 객체 생성
    );
  }
}
