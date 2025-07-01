import 'package:clima_app/features/search/data/datasources/search_weather_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late SearchWeatherDatasourceImpl datasource;

  const endpoint = "https://api.openweathermap.org";
  const appId = "d7f496a9000941071e8d2527c64f26cf";

  setUp( () {
    dio = Dio(BaseOptions(baseUrl: endpoint));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.addAll({'appid': appId});
          return handler.next(options); // continúa
        },
      ),
    );

    dioAdapter = DioAdapter(dio: dio);
    datasource = SearchWeatherDatasourceImpl(dio: dio);
  });
  
  test('debería retornar modelo si la respuesta es exitosa (200)', () async {
    const lat = 16.084983;
    const long = -93.748233;

    const fakeJson = {
      "lat": lat,
      "lon": long,
      "timezone": "America/Mexico_City",
      "timezone_offset": -21600,
      "current": {
        "dt": 1750701510,
        "sunrise": 1750679083,
        "sunset": 1750726183,
        "temp": 305.23,
        "feels_like": 310.11,
        "pressure": 1013,
        "humidity": 59,
        "dew_point": 296.21,
        "uvi": 13.01,
        "clouds": 89,
        "visibility": 10000,
        "wind_speed": 3.38,
        "wind_deg": 257,
        "wind_gust": 2.71,
        "weather": [
          {
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10d"
          }
        ],
        "rain": {"1h": 0.13}
      },
      "hourly" : [
        {
          "dt": 1750698000,
          "temp": 305.17,
          "feels_like": 309.68,
          "pressure": 1013,
          "humidity": 58,
          "dew_point": 295.87,
          "uvi": 11.68,
          "clouds": 91,
          "visibility": 10000,
          "wind_speed": 2.3,
          "wind_deg": 261,
          "wind_gust": 2.06,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0,
        },
      ],
    };

    dioAdapter.onGet("/data/3.0/onecall?lat=$lat&lon=$long", (server) {
      return server.reply(200, fakeJson);
    });

    final result = await datasource.fetchSearchDataByLocation(lat: lat, lon: long);

    expect(result.latitude, equals(lat));
    expect(result.longitude, equals(long));
    expect(result.current.temp, equals(305.23));
  });

}