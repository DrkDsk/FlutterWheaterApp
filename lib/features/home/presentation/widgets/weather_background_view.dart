import 'package:clima_app/core/shared/domain/background_weather.dart';
import 'package:clima_app/core/shared/ui/widgets/lottie_viewer.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBackgroundView extends StatelessWidget {
  const WeatherBackgroundView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CityWeatherBloc, CityWeatherState, BackgroundWeather>(
      selector: (state) => state.backgroundWeather,
      builder: (context, background) {
        return Positioned.fill(
          child: LottieViewer(
            path: background.lottiePath,
            backgroundColor: background.color,
          ),
        );
      },
    );
  }
}
