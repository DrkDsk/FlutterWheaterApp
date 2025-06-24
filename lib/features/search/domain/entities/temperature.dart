class Temperature {
  Temperature({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final double? day;
  final double? min;
  final double? max;
  final double? night;
  final double? eve;
  final double? morn;

  Temperature copyWith({
    double? day,
    double? min,
    double? max,
    double? night,
    double? eve,
    double? morn,
  }) {
    return Temperature(
      day: day ?? this.day,
      min: min ?? this.min,
      max: max ?? this.max,
      night: night ?? this.night,
      eve: eve ?? this.eve,
      morn: morn ?? this.morn,
    );
  }
}