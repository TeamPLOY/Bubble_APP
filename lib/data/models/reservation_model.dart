class ReservationModel {
  final String date;
  final String day;
  final int userCount;

  ReservationModel(
      {required this.date, required this.day, required this.userCount});
  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      date: json["date"],
      day: json["day"],
      userCount: json["userCount"],
    );
  }
}
