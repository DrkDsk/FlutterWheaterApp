import 'package:clima_app/features/home/data/models/current_model.dart';
import 'package:clima_app/features/home/data/models/hourly_model.dart';
import 'package:clima_app/features/home/data/models/rain_model.dart';
import 'package:clima_app/features/home/data/models/weather_response_model.dart';
import 'package:clima_app/features/home/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    const json = {
      "lat": 16.085,
      "lon": -93.7482,
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

    final searchModel = WeatherResponseModel(
      latitude: 16.085,
      longitude: -93.7482,
      timeZone: "America/Mexico_City",
      timezoneOffset: -21600,
      current: CurrentModel(
          dt: 1750701510,
          sunrise: 1750679083,
          sunset: 1750726183,
          temp: 305.23,
          feelsLike: 310.11,
          pressure: 1013,
          humidity: 59,
          dewPoint: 296.21,
          uvi: 13.01,
          clouds: 89,
          visibility: 10000,
          windSpeed: 3.38,
          windDeg: 257,
          windGust: 2.71,
          weather: [
            WeatherModel(
                id: 500, main: "Rain", description: "light rain", icon: "10d"
            )
          ],
          rain: RainModel(the1H: 0.13)
      ),
      hourly: [
        HourlyModel(
            dt: 1750698000,
            temp: 305.17,
            feelsLike: 309.68,
            pressure: 1013,
            humidity: 58,
            dewPoint: 295.87,
            uvi: 11.68,
            clouds: 91,
            visibility: 10000,
            windSpeed: 2.3,
            windDeg: 261,
            windGust: 2.06,
            weather: [
              WeatherModel(
                  id: 804,
                  main: "Clouds",
                  description: "overcast clouds",
                  icon: "04d")
            ],
            pop: 0,
        )
      ],
    );

    test('fromJson debería retornar un UserModel válido', () {
      final result = WeatherResponseModel.fromJson(json);
      expect(result, equals(searchModel));
    });

    test('toJson debería retornar un map correcto', () {
      final result = searchModel.toJson().cleanNulls();
      expect(result, equals(json));
    });
  });
}
