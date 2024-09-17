class EmailGetModels {
  final int code;
  final  String email;

  EmailGetModels({required this.code, required this.email});

  factory EmailGetModels.fromJson(Map<String, dynamic> json){
    return EmailGetModels(code: json['code'], email: json['email'],);
  }
}