import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:clima_app/features/search/domain/entities/location.dart';
import 'package:clima_app/features/search/domain/entities/request.dart';

class SearchResponse {
  SearchResponse({
    required this.request,
    required this.location,
    required this.current,
  });

  final Request? request;
  final Location? location;
  final Current? current;

  SearchResponse copyWith({
    Request? request,
    Location? location,
    Current? current,
  }) {
    return SearchResponse(
      request: request ?? this.request,
      location: location ?? this.location,
      current: current ?? this.current,
    );
  }
}
