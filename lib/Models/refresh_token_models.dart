class RefreshTokenModels {
  late var access_token;
  late var refresh_token;

  RefreshTokenModels({required this.access_token, required this.refresh_token});
  factory RefreshTokenModels.fromJson(Map<String, dynamic> json){
    return RefreshTokenModels(
      access_token: json['access_token'],
      refresh_token: json['refresh_token'],
    );
  }
}