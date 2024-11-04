class RefreshTokenModel {
  late var access_token;
  late var refresh_token;

  RefreshTokenModel({required this.access_token, required this.refresh_token});
  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenModel(
      access_token: json['access_token'],
      refresh_token: json['refresh_token'],
    );
  }
}
