abstract interface class IARepository {
  Future<List<String?>> getRecommendation({
    required String temperatureInCelsius,
    required String feelsLike,
    required String humidity,
    required String windSpeedAndGust,
    required String condition
  });
}