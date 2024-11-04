class NoticeDetailModel {
  final String title;
  final String detail;
  final String date;

  NoticeDetailModel(
      {required this.title, required this.detail, required this.date});

  factory NoticeDetailModel.fromJson(Map<String, dynamic> json) {
    return NoticeDetailModel(
      title: json['title'],
      detail: json['detail'],
      date: json['date'],
    );
  }
}
