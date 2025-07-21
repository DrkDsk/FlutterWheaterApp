class Clouds {
  Clouds({
    required this.all,
  });

  final int? all;

  Clouds copyWith({
    int? all,
  }) {
    return Clouds(
      all: all ?? this.all,
    );
  }

}