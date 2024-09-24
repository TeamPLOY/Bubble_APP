class Machine {
  final String name;
  final double time;

  Machine({
    required this.name,
    required this.time,
  });
  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      name: json["name"],
      time: json["time"].toDouble(),
    );
  }
}
