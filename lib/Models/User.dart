class User {
  final String name;
  final int studentNum;
  final String email;
  final String roomNum;

  User({required this.name,required this.studentNum,required this.email,required this.roomNum});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      name: json['name'],
      studentNum: json['studentNum'],
      email : json['email'],
      roomNum : json['roomNum']
    );
  }
}