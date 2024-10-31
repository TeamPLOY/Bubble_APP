class CheckGetModel {
  final bool isChecked;

  CheckGetModel({required this.isChecked});

  factory CheckGetModel.fromJson(Map<String, dynamic> json) {
    return CheckGetModel(
      isChecked: json['isChecked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isChecked': isChecked,
    };
  }
}
