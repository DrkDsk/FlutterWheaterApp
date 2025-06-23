import 'package:equatable/equatable.dart';

class Request with EquatableMixin {
  Request({
    required this.type,
    required this.query,
    required this.language,
    required this.unit,
  });

  final String? type;
  final String? query;
  final String? language;
  final String? unit;

  Request copyWith({
    String? type,
    String? query,
    String? language,
    String? unit,
  }) {
    return Request(
      type: type ?? this.type,
      query: query ?? this.query,
      language: language ?? this.language,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props => [type, query, language, unit];
}