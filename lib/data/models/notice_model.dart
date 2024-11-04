class Noticemodel {
  final String title;
  final String date;

  Noticemodel({required this.title, required this.date});

  factory Noticemodel.fromJson(Map<String, dynamic> json) {
    return Noticemodel(
      title: json['title'],
      date: json['date'],
    );
  }
}
