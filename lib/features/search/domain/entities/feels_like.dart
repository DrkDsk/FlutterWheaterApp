class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final double? day;
  final double? night;
  final double? eve;
  final double? morn;

  FeelsLike copyWith({
    double? day,
    double? night,
    double? eve,
    double? morn,
  }) {
    return FeelsLike(
      day: day ?? this.day,
      night: night ?? this.night,
      eve: eve ?? this.eve,
      morn: morn ?? this.morn,
    );
  }
}