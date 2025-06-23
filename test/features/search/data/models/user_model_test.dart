import 'package:clima_app/features/search/data/models/air_quality_model.dart';
import 'package:clima_app/features/search/data/models/astro_model.dart';
import 'package:clima_app/features/search/data/models/current_model.dart';
import 'package:clima_app/features/search/data/models/location_model.dart';
import 'package:clima_app/features/search/data/models/request_model.dart';
import 'package:clima_app/features/search/data/models/search_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    const json = {
      "request": {
        "type": "City",
        "query": "New York, United States of America",
        "language": "en",
        "unit": "m"
      },
      "location": {
        "name": "New York",
        "country": "United States of America",
        "region": "New York",
        "lat": "40.714",
        "lon": "-74.006",
        "timezone_id": "America/New_York",
        "localtime": "2019-09-07 08:14",
        "localtime_epoch": 1567844040,
        "utc_offset": "-4.0"
      },
      "current": {
        "observation_time": "12:14 PM",
        "temperature": 13,
        "weather_code": 113,
        "weather_icons": [
          "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png"
        ],
        "weather_descriptions": ["Sunny"],
        "astro": {
          "sunrise": "06:31 AM",
          "sunset": "05:47 PM",
          "moonrise": "06:56 AM",
          "moonset": "06:47 PM",
          "moon_phase": "Waxing Crescent",
          "moon_illumination": 0
        },
        "air_quality": {
          "co": "468.05",
          "no2": "32.005",
          "o3": "55",
          "so2": "7.4",
          "pm2_5": "6.66",
          "pm10": "6.66",
          "us-epa-index": "1",
          "gb-defra-index": "1"
        },
        "wind_speed": 0,
        "wind_degree": 349,
        "wind_dir": "N",
        "pressure": 1010,
        "precip": 0,
        "humidity": 90,
        "cloudcover": 0,
        "feelslike": 13,
        "uv_index": 4,
        "visibility": 16
      }
    };

    final searchModel = SearchResponseModel(
        request: RequestModel(
            type: "City",
            query: "New York, United States of America",
            language: "en",
            unit: "m"),
        location: LocationModel(
            name: "New York",
            country: "United States of America",
            region: "New York",
            lat: "40.714",
            lon: "-74.006",
            timezoneId: "America/New_York",
            localtime: "2019-09-07 08:14",
            localtimeEpoch: 1567844040,
            utcOffset: "-4.0"),
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
      final result = SearchResponseModel.fromJson(json);
      expect(result, equals(searchModel));
    });
    
    /*test('toJson debería retornar un map correcto', () {
      final result = searchModel.toJson();
      expect(result, equals(json));
    });*/
  });
}
