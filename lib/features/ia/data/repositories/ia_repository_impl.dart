import 'package:clima_app/features/ia/data/datasources/ia_datasource.dart';
import 'package:clima_app/features/ia/domain/repositories/ia_repository.dart';

class IaRepositoryImpl implements IARepository {
  final IADatasource _iaDatasource;

  const IaRepositoryImpl({required IADatasource datasource})
      : _iaDatasource = datasource;

  @override
  Future<List<String?>> getRecommendation(
      {required String temperatureInCelsius,
      required String feelsLike,
      required String humidity,
      required String windSpeedAndGust,
      required String condition}) async {

    final prompt = "Convierte estos datos del clima en una descripción natural y amigable para el usuario. \n"
        "Temperatura: $temperatureInCelsius \n"
        "Sensación térmica: $feelsLike \n"
        "Humedad: $humidity \n"
        "Viento: $windSpeedAndGust \n"
        "Condición: $condition \n";

    final response = await _iaDatasource.generateText(prompt: prompt);

    return response;
  }
}
