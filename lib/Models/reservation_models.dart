class ReservationModels {
  final String date;
  final String day;
  final int userCount;

  ReservationModels({required this.date, required this.day, required this.userCount});
  factory ReservationModels.fromJson(Map<String, dynamic> json) {
    return ReservationModels(
      date: json["date"],
      day: json["day"],
      userCount: json["userCount"],
    );
  }
}

