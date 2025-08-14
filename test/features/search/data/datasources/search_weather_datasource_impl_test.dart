import 'package:clima_app/core/dio_client.dart';
import 'package:clima_app/features/home/data/datasources/search_weather_datasource_impl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioClient dioClient;
  late DioAdapter dioAdapter;
  late SearchWeatherDatasourceImpl datasource;

  setUp( () {
    final appId = dotenv.env["WEATHER_APP_ID"]!;
    dioClient = DioClient(apiKey: appId);
    var dio = dioClient.dio;
    dioAdapter = DioAdapter(dio: dio);
    datasource = SearchWeatherDatasourceImpl(dio: dio);
  });
  
  test('debería retornar modelo si la respuesta es exitosa (200)', () async {
    const lat = 16.084983;
    const long = -93.748233;
    const temp = 306.07;

    const fakeJson = {
      "lat": lat,
      "lon": long,
      "timezone": "America/Mexico_City",
      "timezone_offset": -21600,
      "current": {
        "dt": 1751390454,
        "sunrise": 1751370404,
        "sunset": 1751417447,
        "temp": temp,
        "feels_like": 311.77,
        "pressure": 1012,
        "humidity": 58,
        "dew_point": 296.71,
        "uvi": 10.25,
        "clouds": 100,
        "visibility": 10000,
        "wind_speed": 2.57,
        "wind_deg": 263,
        "wind_gust": 2.24,
        "weather": [
          {
            "id": 804,
            "main": "Clouds",
            "description": "overcast clouds",
            "icon": "04d"
          }
        ]
      },
      "hourly": [
        {
          "dt": 1751389200,
          "temp": 306.07,
          "feels_like": 311.77,
          "pressure": 1012,
          "humidity": 58,
          "dew_point": 296.71,
          "uvi": 10.25,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 2.57,
          "wind_deg": 263,
          "wind_gust": 2.24,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751392800,
          "temp": 306.2,
          "feels_like": 311.74,
          "pressure": 1012,
          "humidity": 57,
          "dew_point": 296.54,
          "uvi": 12.03,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 2.99,
          "wind_deg": 264,
          "wind_gust": 2.93,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751396400,
          "temp": 306.48,
          "feels_like": 312.42,
          "pressure": 1011,
          "humidity": 57,
          "dew_point": 296.8,
          "uvi": 12.21,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 3.02,
          "wind_deg": 262,
          "wind_gust": 3.25,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751400000,
          "temp": 306.37,
          "feels_like": 312.87,
          "pressure": 1010,
          "humidity": 59,
          "dew_point": 297.27,
          "uvi": 9.78,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 2.79,
          "wind_deg": 253,
          "wind_gust": 3.05,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "pop": 0.2,
          "rain": {
            "1h": 0.1
          }
        },
        {
          "dt": 1751403600,
          "temp": 305.89,
          "feels_like": 312.71,
          "pressure": 1010,
          "humidity": 62,
          "dew_point": 297.65,
          "uvi": 6.69,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 2.21,
          "wind_deg": 246,
          "wind_gust": 1.96,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "pop": 0.67,
          "rain": {
            "1h": 0.43
          }
        },
        {
          "dt": 1751407200,
          "temp": 304.6,
          "feels_like": 311.33,
          "pressure": 1009,
          "humidity": 68,
          "dew_point": 296.91,
          "uvi": 3.31,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 1.96,
          "wind_deg": 217,
          "wind_gust": 1.44,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "pop": 0.84,
          "rain": {
            "1h": 0.51
          }
        },
        {
          "dt": 1751410800,
          "temp": 303.05,
          "feels_like": 310.05,
          "pressure": 1010,
          "humidity": 79,
          "dew_point": 297.93,
          "uvi": 1.26,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 2.36,
          "wind_deg": 178,
          "wind_gust": 1.86,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "pop": 0.94,
          "rain": {
            "1h": 0.96
          }
        },
        {
          "dt": 1751414400,
          "temp": 301.59,
          "feels_like": 307.32,
          "pressure": 1010,
          "humidity": 85,
          "dew_point": 297.64,
          "uvi": 0.25,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 2.54,
          "wind_deg": 140,
          "wind_gust": 3.02,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "pop": 1,
          "rain": {
            "1h": 0.41
          }
        },
        {
          "dt": 1751418000,
          "temp": 300.28,
          "feels_like": 303.81,
          "pressure": 1011,
          "humidity": 86,
          "dew_point": 296.56,
          "uvi": 0,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 2.07,
          "wind_deg": 99,
          "wind_gust": 2.05,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 0.98,
          "rain": {
            "1h": 0.43
          }
        },
        {
          "dt": 1751421600,
          "temp": 300.21,
          "feels_like": 303.32,
          "pressure": 1011,
          "humidity": 83,
          "dew_point": 296.01,
          "uvi": 0,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 1.86,
          "wind_deg": 104,
          "wind_gust": 1.48,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "pop": 0.73
        },
        {
          "dt": 1751425200,
          "temp": 299.88,
          "feels_like": 302.62,
          "pressure": 1012,
          "humidity": 84,
          "dew_point": 295.82,
          "uvi": 0,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 2.44,
          "wind_deg": 111,
          "wind_gust": 1.99,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "pop": 0.84
        },
        {
          "dt": 1751428800,
          "temp": 299.41,
          "feels_like": 299.41,
          "pressure": 1013,
          "humidity": 86,
          "dew_point": 295.59,
          "uvi": 0,
          "clouds": 99,
          "visibility": 10000,
          "wind_speed": 3.02,
          "wind_deg": 89,
          "wind_gust": 2.92,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 0.84,
          "rain": {
            "1h": 0.18
          }
        },
        {
          "dt": 1751432400,
          "temp": 299.22,
          "feels_like": 299.22,
          "pressure": 1013,
          "humidity": 85,
          "dew_point": 295.52,
          "uvi": 0,
          "clouds": 99,
          "visibility": 10000,
          "wind_speed": 2.98,
          "wind_deg": 73,
          "wind_gust": 2.79,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "pop": 0.8
        },
        {
          "dt": 1751436000,
          "temp": 299.19,
          "feels_like": 299.19,
          "pressure": 1012,
          "humidity": 84,
          "dew_point": 295.25,
          "uvi": 0,
          "clouds": 99,
          "visibility": 10000,
          "wind_speed": 2.69,
          "wind_deg": 76,
          "wind_gust": 2.3,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 0.8,
          "rain": {
            "1h": 0.1
          }
        },
        {
          "dt": 1751439600,
          "temp": 299.3,
          "feels_like": 299.3,
          "pressure": 1012,
          "humidity": 82,
          "dew_point": 294.98,
          "uvi": 0,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 2.24,
          "wind_deg": 70,
          "wind_gust": 2.2,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 0.96,
          "rain": {
            "1h": 0.32
          }
        },
        {
          "dt": 1751443200,
          "temp": 298.37,
          "feels_like": 299.22,
          "pressure": 1011,
          "humidity": 87,
          "dew_point": 295.02,
          "uvi": 0,
          "clouds": 100,
          "visibility": 8235,
          "wind_speed": 1.9,
          "wind_deg": 47,
          "wind_gust": 1.81,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 1,
          "rain": {
            "1h": 0.74
          }
        },
        {
          "dt": 1751446800,
          "temp": 298.17,
          "feels_like": 299.03,
          "pressure": 1011,
          "humidity": 88,
          "dew_point": 295.06,
          "uvi": 0,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 1.7,
          "wind_deg": 25,
          "wind_gust": 1.61,
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10n"
            }
          ],
          "pop": 1,
          "rain": {
            "1h": 1.69
          }
        },
        {
          "dt": 1751450400,
          "temp": 298.44,
          "feels_like": 299.3,
          "pressure": 1011,
          "humidity": 87,
          "dew_point": 295.04,
          "uvi": 0,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 1.91,
          "wind_deg": 6,
          "wind_gust": 1.7,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "pop": 0.8
        },
        {
          "dt": 1751454000,
          "temp": 298.35,
          "feels_like": 299.2,
          "pressure": 1011,
          "humidity": 87,
          "dew_point": 294.92,
          "uvi": 0,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 1.33,
          "wind_deg": 37,
          "wind_gust": 1.51,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "pop": 0.8
        },
        {
          "dt": 1751457600,
          "temp": 298.27,
          "feels_like": 299.11,
          "pressure": 1011,
          "humidity": 87,
          "dew_point": 294.92,
          "uvi": 0,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 1.82,
          "wind_deg": 45,
          "wind_gust": 1.51,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0.8
        },
        {
          "dt": 1751461200,
          "temp": 299.78,
          "feels_like": 299.78,
          "pressure": 1011,
          "humidity": 85,
          "dew_point": 295.89,
          "uvi": 0.6,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 1.84,
          "wind_deg": 54,
          "wind_gust": 1.53,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751464800,
          "temp": 301.87,
          "feels_like": 305.98,
          "pressure": 1012,
          "humidity": 74,
          "dew_point": 295.92,
          "uvi": 1.79,
          "clouds": 81,
          "visibility": 10000,
          "wind_speed": 1.21,
          "wind_deg": 52,
          "wind_gust": 1.24,
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751468400,
          "temp": 303.81,
          "feels_like": 309.03,
          "pressure": 1012,
          "humidity": 67,
          "dew_point": 295.86,
          "uvi": 3.89,
          "clouds": 89,
          "visibility": 10000,
          "wind_speed": 0.7,
          "wind_deg": 7,
          "wind_gust": 1.93,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751472000,
          "temp": 305.86,
          "feels_like": 311.6,
          "pressure": 1011,
          "humidity": 59,
          "dew_point": 295.94,
          "uvi": 7.22,
          "clouds": 93,
          "visibility": 10000,
          "wind_speed": 0.82,
          "wind_deg": 294,
          "wind_gust": 2.76,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751475600,
          "temp": 307.16,
          "feels_like": 313.36,
          "pressure": 1011,
          "humidity": 55,
          "dew_point": 296.07,
          "uvi": 10.88,
          "clouds": 95,
          "visibility": 10000,
          "wind_speed": 1.44,
          "wind_deg": 233,
          "wind_gust": 2.4,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751479200,
          "temp": 307.31,
          "feels_like": 314.12,
          "pressure": 1011,
          "humidity": 56,
          "dew_point": 296.46,
          "uvi": 12.31,
          "clouds": 95,
          "visibility": 10000,
          "wind_speed": 1.78,
          "wind_deg": 228,
          "wind_gust": 2.26,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751482800,
          "temp": 306.85,
          "feels_like": 313.85,
          "pressure": 1010,
          "humidity": 59,
          "dew_point": 296.92,
          "uvi": 12.22,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 2.37,
          "wind_deg": 213,
          "wind_gust": 2.78,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "pop": 0.06
        },
        {
          "dt": 1751486400,
          "temp": 305.9,
          "feels_like": 312.9,
          "pressure": 1010,
          "humidity": 64,
          "dew_point": 297.15,
          "uvi": 10.06,
          "clouds": 99,
          "visibility": 10000,
          "wind_speed": 2.38,
          "wind_deg": 212,
          "wind_gust": 2.11,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "pop": 0.94,
          "rain": {
            "1h": 0.71
          }
        },
        {
          "dt": 1751490000,
          "temp": 305.12,
          "feels_like": 312.12,
          "pressure": 1010,
          "humidity": 67,
          "dew_point": 297.23,
          "uvi": 6.62,
          "clouds": 98,
          "visibility": 10000,
          "wind_speed": 2.26,
          "wind_deg": 212,
          "wind_gust": 1.82,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "pop": 1,
          "rain": {
            "1h": 0.81
          }
        },
        {
          "dt": 1751493600,
          "temp": 304.46,
          "feels_like": 311.28,
          "pressure": 1009,
          "humidity": 69,
          "dew_point": 297,
          "uvi": 3.26,
          "clouds": 98,
          "visibility": 10000,
          "wind_speed": 2,
          "wind_deg": 211,
          "wind_gust": 1.61,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "pop": 1,
          "rain": {
            "1h": 0.98
          }
        },
        {
          "dt": 1751497200,
          "temp": 303.44,
          "feels_like": 310.44,
          "pressure": 1010,
          "humidity": 76,
          "dew_point": 297.84,
          "uvi": 1.28,
          "clouds": 98,
          "visibility": 10000,
          "wind_speed": 1.87,
          "wind_deg": 194,
          "wind_gust": 1.83,
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10d"
            }
          ],
          "pop": 1,
          "rain": {
            "1h": 1.01
          }
        },
        {
          "dt": 1751500800,
          "temp": 301.96,
          "feels_like": 308.43,
          "pressure": 1010,
          "humidity": 85,
          "dew_point": 298.11,
          "uvi": 0.24,
          "clouds": 99,
          "visibility": 10000,
          "wind_speed": 1.55,
          "wind_deg": 162,
          "wind_gust": 1.89,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "pop": 1,
          "rain": {
            "1h": 0.65
          }
        },
        {
          "dt": 1751504400,
          "temp": 300.26,
          "feels_like": 303.87,
          "pressure": 1011,
          "humidity": 87,
          "dew_point": 296.76,
          "uvi": 0,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 1.56,
          "wind_deg": 121,
          "wind_gust": 1.86,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 0.82,
          "rain": {
            "1h": 0.42
          }
        },
        {
          "dt": 1751508000,
          "temp": 299.63,
          "feels_like": 299.63,
          "pressure": 1012,
          "humidity": 89,
          "dew_point": 296.62,
          "uvi": 0,
          "clouds": 100,
          "visibility": 10000,
          "wind_speed": 1.9,
          "wind_deg": 82,
          "wind_gust": 1.87,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 0.74,
          "rain": {
            "1h": 0.1
          }
        },
        {
          "dt": 1751511600,
          "temp": 298.82,
          "feels_like": 299.79,
          "pressure": 1012,
          "humidity": 90,
          "dew_point": 296.04,
          "uvi": 0,
          "clouds": 99,
          "visibility": 10000,
          "wind_speed": 1.95,
          "wind_deg": 59,
          "wind_gust": 1.55,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 1,
          "rain": {
            "1h": 0.67
          }
        },
        {
          "dt": 1751515200,
          "temp": 298.6,
          "feels_like": 299.55,
          "pressure": 1013,
          "humidity": 90,
          "dew_point": 295.91,
          "uvi": 0,
          "clouds": 96,
          "visibility": 10000,
          "wind_speed": 2.11,
          "wind_deg": 64,
          "wind_gust": 1.79,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 1,
          "rain": {
            "1h": 0.57
          }
        },
        {
          "dt": 1751518800,
          "temp": 298.55,
          "feels_like": 299.44,
          "pressure": 1013,
          "humidity": 88,
          "dew_point": 295.33,
          "uvi": 0,
          "clouds": 92,
          "visibility": 10000,
          "wind_speed": 2.12,
          "wind_deg": 59,
          "wind_gust": 1.7,
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "pop": 0.8
        },
        {
          "dt": 1751522400,
          "temp": 298.47,
          "feels_like": 299.3,
          "pressure": 1013,
          "humidity": 86,
          "dew_point": 294.81,
          "uvi": 0,
          "clouds": 79,
          "visibility": 10000,
          "wind_speed": 1.92,
          "wind_deg": 47,
          "wind_gust": 1.42,
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04n"
            }
          ],
          "pop": 0.8
        },
        {
          "dt": 1751526000,
          "temp": 298.11,
          "feels_like": 298.91,
          "pressure": 1012,
          "humidity": 86,
          "dew_point": 294.44,
          "uvi": 0,
          "clouds": 22,
          "visibility": 10000,
          "wind_speed": 1.94,
          "wind_deg": 37,
          "wind_gust": 1.32,
          "weather": [
            {
              "id": 801,
              "main": "Clouds",
              "description": "few clouds",
              "icon": "02n"
            }
          ],
          "pop": 0.31
        },
        {
          "dt": 1751529600,
          "temp": 297.14,
          "feels_like": 297.92,
          "pressure": 1012,
          "humidity": 89,
          "dew_point": 294.22,
          "uvi": 0,
          "clouds": 53,
          "visibility": 10000,
          "wind_speed": 2.19,
          "wind_deg": 36,
          "wind_gust": 1.43,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 0.99,
          "rain": {
            "1h": 0.6
          }
        },
        {
          "dt": 1751533200,
          "temp": 297.22,
          "feels_like": 298.01,
          "pressure": 1012,
          "humidity": 89,
          "dew_point": 294.14,
          "uvi": 0,
          "clouds": 60,
          "visibility": 10000,
          "wind_speed": 1.96,
          "wind_deg": 32,
          "wind_gust": 1.32,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10n"
            }
          ],
          "pop": 1,
          "rain": {
            "1h": 0.51
          }
        },
        {
          "dt": 1751536800,
          "temp": 297.41,
          "feels_like": 298.16,
          "pressure": 1012,
          "humidity": 87,
          "dew_point": 294.05,
          "uvi": 0,
          "clouds": 52,
          "visibility": 10000,
          "wind_speed": 1.89,
          "wind_deg": 37,
          "wind_gust": 1.31,
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04n"
            }
          ],
          "pop": 0.8
        },
        {
          "dt": 1751540400,
          "temp": 297.53,
          "feels_like": 298.27,
          "pressure": 1012,
          "humidity": 86,
          "dew_point": 293.93,
          "uvi": 0,
          "clouds": 46,
          "visibility": 10000,
          "wind_speed": 1.76,
          "wind_deg": 39,
          "wind_gust": 1.11,
          "weather": [
            {
              "id": 802,
              "main": "Clouds",
              "description": "scattered clouds",
              "icon": "03n"
            }
          ],
          "pop": 0.72
        },
        {
          "dt": 1751544000,
          "temp": 297.52,
          "feels_like": 298.26,
          "pressure": 1013,
          "humidity": 86,
          "dew_point": 294.03,
          "uvi": 0,
          "clouds": 42,
          "visibility": 10000,
          "wind_speed": 1.68,
          "wind_deg": 40,
          "wind_gust": 1.18,
          "weather": [
            {
              "id": 802,
              "main": "Clouds",
              "description": "scattered clouds",
              "icon": "03d"
            }
          ],
          "pop": 0.84
        },
        {
          "dt": 1751547600,
          "temp": 299.64,
          "feels_like": 299.64,
          "pressure": 1013,
          "humidity": 84,
          "dew_point": 295.58,
          "uvi": 0.58,
          "clouds": 17,
          "visibility": 10000,
          "wind_speed": 1.32,
          "wind_deg": 23,
          "wind_gust": 1.09,
          "weather": [
            {
              "id": 801,
              "main": "Clouds",
              "description": "few clouds",
              "icon": "02d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751551200,
          "temp": 301.36,
          "feels_like": 305.13,
          "pressure": 1013,
          "humidity": 76,
          "dew_point": 295.68,
          "uvi": 1.8,
          "clouds": 37,
          "visibility": 10000,
          "wind_speed": 1.34,
          "wind_deg": 329,
          "wind_gust": 1.07,
          "weather": [
            {
              "id": 802,
              "main": "Clouds",
              "description": "scattered clouds",
              "icon": "03d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751554800,
          "temp": 302.78,
          "feels_like": 307.3,
          "pressure": 1013,
          "humidity": 70,
          "dew_point": 295.72,
          "uvi": 3.73,
          "clouds": 57,
          "visibility": 10000,
          "wind_speed": 1.94,
          "wind_deg": 289,
          "wind_gust": 1.41,
          "weather": [
            {
              "id": 803,
              "main": "Clouds",
              "description": "broken clouds",
              "icon": "04d"
            }
          ],
          "pop": 0
        },
        {
          "dt": 1751558400,
          "temp": 304.09,
          "feels_like": 309.16,
          "pressure": 1013,
          "humidity": 65,
          "dew_point": 295.83,
          "uvi": 6.66,
          "clouds": 49,
          "visibility": 10000,
          "wind_speed": 2.39,
          "wind_deg": 252,
          "wind_gust": 1.58,
          "weather": [
            {
              "id": 802,
              "main": "Clouds",
              "description": "scattered clouds",
              "icon": "03d"
            }
          ],
          "pop": 0
        }
      ],
      "daily": [
        {
          "dt": 1751392800,
          "sunrise": 1751370404,
          "sunset": 1751417447,
          "moonrise": 1751390820,
          "moonset": 1751434980,
          "moon_phase": 0.22,
          "summary": "Expect a day of partly cloudy with rain",
          "temp": {
            "day": 306.2,
            "min": 297.44,
            "max": 306.48,
            "night": 299.22,
            "eve": 301.59,
            "morn": 297.51
          },
          "feels_like": {
            "day": 311.74,
            "night": 299.22,
            "eve": 307.32,
            "morn": 298.22
          },
          "pressure": 1012,
          "humidity": 57,
          "dew_point": 296.54,
          "wind_speed": 3.02,
          "wind_deg": 262,
          "wind_gust": 3.25,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": 100,
          "pop": 1,
          "rain": 3.02,
          "uvi": 12.21
        },
        {
          "dt": 1751479200,
          "sunrise": 1751456821,
          "sunset": 1751503851,
          "moonrise": 1751480040,
          "moonset": 0,
          "moon_phase": 0.25,
          "summary": "Expect a day of partly cloudy with rain",
          "temp": {
            "day": 307.31,
            "min": 298.17,
            "max": 307.31,
            "night": 298.55,
            "eve": 301.96,
            "morn": 298.27
          },
          "feels_like": {
            "day": 314.12,
            "night": 299.44,
            "eve": 308.43,
            "morn": 299.11
          },
          "pressure": 1011,
          "humidity": 56,
          "dew_point": 296.46,
          "wind_speed": 2.69,
          "wind_deg": 76,
          "wind_gust": 2.78,
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10d"
            }
          ],
          "clouds": 95,
          "pop": 1,
          "rain": 8.77,
          "uvi": 12.31
        },
        {
          "dt": 1751565600,
          "sunrise": 1751543239,
          "sunset": 1751590255,
          "moonrise": 1751569260,
          "moonset": 1751523360,
          "moon_phase": 0.28,
          "summary": "Expect a day of partly cloudy with rain",
          "temp": {
            "day": 304.49,
            "min": 297.14,
            "max": 304.76,
            "night": 297.27,
            "eve": 300.78,
            "morn": 297.52
          },
          "feels_like": {
            "day": 310.43,
            "night": 298.19,
            "eve": 304.88,
            "morn": 298.26
          },
          "pressure": 1013,
          "humidity": 66,
          "dew_point": 296.37,
          "wind_speed": 4.2,
          "wind_deg": 237,
          "wind_gust": 2.56,
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10d"
            }
          ],
          "clouds": 60,
          "pop": 1,
          "rain": 6.94,
          "uvi": 11.58
        },
        {
          "dt": 1751652000,
          "sunrise": 1751629656,
          "sunset": 1751676658,
          "moonrise": 1751658540,
          "moonset": 1751611800,
          "moon_phase": 0.31,
          "summary": "Expect a day of partly cloudy with rain",
          "temp": {
            "day": 300.58,
            "min": 296.99,
            "max": 302.46,
            "night": 296.99,
            "eve": 298.1,
            "morn": 297.75
          },
          "feels_like": {
            "day": 304.24,
            "night": 297.99,
            "eve": 299.13,
            "morn": 298.62
          },
          "pressure": 1015,
          "humidity": 83,
          "dew_point": 296.56,
          "wind_speed": 2.95,
          "wind_deg": 195,
          "wind_gust": 3.25,
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10d"
            }
          ],
          "clouds": 100,
          "pop": 1,
          "rain": 6.44,
          "uvi": 8.14
        },
        {
          "dt": 1751738400,
          "sunrise": 1751716074,
          "sunset": 1751763060,
          "moonrise": 1751747940,
          "moonset": 1751700360,
          "moon_phase": 0.34,
          "summary": "Expect a day of partly cloudy with rain",
          "temp": {
            "day": 303.16,
            "min": 296.21,
            "max": 303.48,
            "night": 298.07,
            "eve": 300.49,
            "morn": 296.21
          },
          "feels_like": {
            "day": 308.46,
            "night": 299.02,
            "eve": 304.49,
            "morn": 296.95
          },
          "pressure": 1014,
          "humidity": 71,
          "dew_point": 296.4,
          "wind_speed": 2.75,
          "wind_deg": 254,
          "wind_gust": 2.2,
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10d"
            }
          ],
          "clouds": 96,
          "pop": 1,
          "rain": 9.18,
          "uvi": 9
        },
        {
          "dt": 1751824800,
          "sunrise": 1751802492,
          "sunset": 1751849461,
          "moonrise": 1751837460,
          "moonset": 1751789160,
          "moon_phase": 0.37,
          "summary": "Expect a day of partly cloudy with rain",
          "temp": {
            "day": 301.07,
            "min": 296.89,
            "max": 302.36,
            "night": 297.18,
            "eve": 298.44,
            "morn": 296.89
          },
          "feels_like": {
            "day": 304.76,
            "night": 298.04,
            "eve": 299.4,
            "morn": 297.59
          },
          "pressure": 1014,
          "humidity": 78,
          "dew_point": 295.78,
          "wind_speed": 2.54,
          "wind_deg": 51,
          "wind_gust": 3.94,
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10d"
            }
          ],
          "clouds": 98,
          "pop": 1,
          "rain": 12.45,
          "uvi": 9
        },
        {
          "dt": 1751911200,
          "sunrise": 1751888910,
          "sunset": 1751935862,
          "moonrise": 1751927100,
          "moonset": 1751878200,
          "moon_phase": 0.4,
          "summary": "Expect a day of partly cloudy with rain",
          "temp": {
            "day": 304.6,
            "min": 296.46,
            "max": 304.6,
            "night": 297.9,
            "eve": 299.81,
            "morn": 296.73
          },
          "feels_like": {
            "day": 310.41,
            "night": 298.86,
            "eve": 299.81,
            "morn": 297.39
          },
          "pressure": 1013,
          "humidity": 65,
          "dew_point": 296.37,
          "wind_speed": 3.19,
          "wind_deg": 251,
          "wind_gust": 2.2,
          "weather": [
            {
              "id": 501,
              "main": "Rain",
              "description": "moderate rain",
              "icon": "10d"
            }
          ],
          "clouds": 100,
          "pop": 1,
          "rain": 11.88,
          "uvi": 9
        },
        {
          "dt": 1751997600,
          "sunrise": 1751975328,
          "sunset": 1752022261,
          "moonrise": 1752016800,
          "moonset": 1751967540,
          "moon_phase": 0.43,
          "summary": "Expect a day of partly cloudy with rain",
          "temp": {
            "day": 304.54,
            "min": 296.86,
            "max": 304.54,
            "night": 297.67,
            "eve": 301.56,
            "morn": 296.86
          },
          "feels_like": {
            "day": 307.32,
            "night": 298.29,
            "eve": 305.6,
            "morn": 297.51
          },
          "pressure": 1014,
          "humidity": 54,
          "dew_point": 293.36,
          "wind_speed": 2.75,
          "wind_deg": 51,
          "wind_gust": 2.96,
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "clouds": 100,
          "pop": 1,
          "rain": 1.65,
          "uvi": 9
        }
      ]
    };

    dioAdapter.onGet("/data/3.0/onecall?lat=$lat&lon=$long", (server) {
      return server.reply(200, fakeJson);
    });

    final result = await datasource.fetchSearchDataByLocation(lat: lat, lon: long);

    expect(result.latitude, equals(lat));
    expect(result.longitude, equals(long));
    expect(result.current.temp, equals(temp));
  });
}