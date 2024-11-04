class MachineModel {
  final String name;
  final double time;

  MachineModel({
    required this.name,
    required this.time,
  });
  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
      name: json["name"],
      time: json["time"].toDouble(),
    );
  }
}
