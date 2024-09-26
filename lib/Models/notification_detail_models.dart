class NotificationDetailModels {
  final String title;
  final String detail;
  final String date;

  NotificationDetailModels({required this.title,required this.detail, required this.date});


  factory NotificationDetailModels.fromJson(Map<String,dynamic> json){
    return NotificationDetailModels(
      title: json['title'],
      detail: json['detail'],
      date: json['date'],
    );
  } 
}