class UserModel {
  final String name;
  final int studentNum;
  final String email;
  final String roomNum;
  final String washingRoom;
  final String token;

  UserModel(
      {required this.name,
      required this.studentNum,
      required this.email,
      required this.roomNum,
      required this.washingRoom,
      required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        studentNum: json['studentNum'],
        email: json['email'],
        roomNum: json['roomNum'],
        washingRoom: json['washingRoom'],
        token: json['token']);
  }
}
