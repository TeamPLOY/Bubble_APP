class ReservationStateModel {
  final String date;
  final bool cancel;
  final String washingRoom;

  ReservationStateModel({ required this.date,required this.cancel,required this.washingRoom});

    factory ReservationStateModel.fromJson(Map<String,dynamic> json){
    return ReservationStateModel(
      date: json['date'],
      cancel: json['cancel'],
      washingRoom: json['washingRoom']
    );
  } 
}