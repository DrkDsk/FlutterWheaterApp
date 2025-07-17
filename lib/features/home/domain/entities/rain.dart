class Rain {
  Rain({
    required this.the1H,
  });

  final double? the1H;

  Rain copyWith({
    double? the1H,
  }) {
    return Rain(
      the1H: the1H ?? this.the1H,
    );
  }
}