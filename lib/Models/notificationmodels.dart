class Notificationmodels {
  final String title;
  final String date;

  Notificationmodels({required this.title,required this.date});

  factory Notificationmodels.fromJson(Map<String,dynamic> json){
    return Notificationmodels(
      title: json['title'],
      date: json['date'],
    );
  } 
}