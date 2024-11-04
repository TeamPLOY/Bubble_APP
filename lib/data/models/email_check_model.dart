class EmailCheckmodel {
  final bool check;

  EmailCheckmodel({
    required this.check,
  });

  factory EmailCheckmodel.fromJson(Map<String, dynamic> json) {
    return EmailCheckmodel(
      check: json['check'],
    );
  }
}
