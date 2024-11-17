class ReservationStateModel {
  final String date;
  final bool cancel;
  final String washingRoom;
  final String dayOfWeek;
  final String machine;
  ReservationStateModel({ required this.machine ,required this.dayOfWeek, required this.date,required this.cancel,required this.washingRoom});

    factory ReservationStateModel.fromJson(Map<String,dynamic> json){
    return ReservationStateModel(
      date: json['date'],
      cancel: json['cancel'],
      washingRoom: json['washingRoom'],
      dayOfWeek : json['dayOfWeek'],
      machine : json['machine'],
    );
  } 
}