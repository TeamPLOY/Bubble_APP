class Reservation {
  final String date;
  final String day;
  final int userCount;

  Reservation({required this.date, required this.day, required this.userCount});
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      date: json["date"],
      day: json["day"],
      userCount: json["userCount"],
    );
  }
