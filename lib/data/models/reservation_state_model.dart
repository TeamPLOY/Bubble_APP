class ReservationStateModel {
  final String date;
  final String resDate;
  final bool cancel;
  final String washingRoom;

  ReservationStateModel({ required this.date,required this.resDate,required this.cancel,required this.washingRoom});

    factory ReservationStateModel.fromJson(Map<String,dynamic> json){
    return ReservationStateModel(
      date: json['date'],
      resDate: json['resDate'],
      cancel: json['cancel'],
      washingRoom: json['washingRoom']
    );
  } 
}