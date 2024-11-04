class EmailGetModel {
  final int code;
  final String email;

  EmailGetModel({required this.code, required this.email});

  factory EmailGetModel.fromJson(Map<String, dynamic> json) {
    return EmailGetModel(
      code: json['code'],
      email: json['email'],
    );
  }
}
