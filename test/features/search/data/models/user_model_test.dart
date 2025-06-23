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
        "rain": {
          "1h": 0.13
        }
      },
    };

    /*final searchModel = WeatherResponseModel(
        current: CurrentModel(
            observationTime: "12:14 PM",
            temperature: 13,
            weatherCode: 113,
            weatherIcons: [
              "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png"
            ],
            weatherDescriptions: ["Sunny"],
            astro: AstroModel(
                sunrise: "06:31 AM",
                sunset: "05:47 PM",
                moonrise: "06:56 AM",
                moonset: "06:47 PM",
                moonPhase: "Waxing Crescent",
                moonIllumination: 0),
            airQuality: AirQualityModel(
                co: "468.05",
                no2: "32.005",
                o3: "55",
                so2: "7.4",
                pm25: "6.66",
                pm10: "6.66",
                usEpaIndex: "1",
                gbDefraIndex: "1"
            ),
            windSpeed: 0,
            windDegree: 349,
            windDir: "N",
            pressure: 1010,
            precip: 0,
            humidity: 90,
            cloudcover: 0,
            feelslike: 13,
            uvIndex: 4,
            visibility: 16
        )
    );

    test('fromJson debería retornar un UserModel válido', () {
      final result = WeatherResponseModel.fromJson(json);
      expect(result, equals(searchModel));
    });*/
    
    /*test('toJson debería retornar un map correcto', () {
      final result = searchModel.toJson();
      expect(result, equals(json));
    });*/
  });
}
