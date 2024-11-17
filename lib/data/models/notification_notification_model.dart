class NotificationNotificationModel {
  final String name;
  final String machine;
  final String date;

  NotificationNotificationModel({required this.name,required this.machine, required this.date});

  factory NotificationNotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationNotificationModel(
      name: json['name'],
      machine:json['machine'],
      date: json['date'],
    );
  }
}