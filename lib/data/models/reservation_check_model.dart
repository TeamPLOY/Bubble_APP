class ReservationCheckModel {
  final bool isChecked;

  ReservationCheckModel({required this.isChecked});

  factory ReservationCheckModel.fromJson(Map<String, dynamic> json) {
    return ReservationCheckModel(
      isChecked: json['isChecked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isChecked': isChecked,
    };
  }
}
