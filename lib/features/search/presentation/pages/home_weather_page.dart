import 'package:clima_app/features/search/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/search/presentation/blocs/cubits/theme_cubit.dart';
import 'package:clima_app/features/search/presentation/widgets/daily_list_weather_widget.dart';
import 'package:clima_app/features/search/presentation/widgets/header_weather_widget.dart';
import 'package:clima_app/features/search/presentation/widgets/hourly_list_weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWeatherPage extends StatefulWidget {
  const HomeWeatherPage({super.key});

  @override
  State<HomeWeatherPage> createState() => _HomeWeatherPageState();
}

class _HomeWeatherPageState extends State<HomeWeatherPage> {

  late BackgroundWeatherCubit backgroundWeatherCubit;

  @override
  void initState() {
    super.initState();
    backgroundWeatherCubit = context.read<BackgroundWeatherCubit>();
  }

  @override
  Widget build(BuildContext context) {

    final themeCubit = context.watch<ThemeCubit>();
    final theme = Theme.of(context);

    final forecastData = [
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s', 'temp' : 36.4},
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s', 'temp' : 36.4},
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s', 'temp' : 36.4},
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s', 'temp' : 36.4},
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s', 'temp' : 36.4},
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s', 'temp' : 36.4},
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s', 'temp' : 36.4},
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s', 'temp' : 36.4},
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s', 'temp' : 36.4},
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s', 'temp' : 36.4},
      {'hour': '16:00', 'icon': Icons.cloud, 'rain': '37%', 'wind': '7 m/s', 'temp' : 38.1},
      {'hour': '17:00', 'icon': Icons.wb_sunny, 'rain': '23%', 'wind': '4 m/s', 'temp' : 29.6},
      {'hour': '18:00', 'icon': Icons.cloud, 'rain': '45%', 'wind': '6 m/s', 'temp' : 29.6},
      {'hour': '19:00', 'icon': Icons.cloudy_snowing, 'rain': '75%', 'wind': '7 m/s', 'temp' : 30.6},
    ];

    return Scaffold(
      body: Container(
        color: backgroundWeatherCubit.state,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                  ),
                ),
              ],
            ),
            Positioned(
              child: SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left:16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("City",
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                            IconButton(
                              icon: Icon(themeCubit.state.isDarkMode ? Icons.nightlight : Icons.sunny),
                              color: theme.colorScheme.onPrimary,
                              onPressed: () {
                                themeCubit.toggleTheme();
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Text(
                          "Wed",
                          style: theme.textTheme.bodyMedium
                        ),
                        const SizedBox(height: 10),
                        const HeaderWeatherWidget(temp: 26),
                        const SizedBox(height: 20),
                        HourlyListWeatherWidget(forecastData: forecastData),
                        const SizedBox(height: 20),
                        DailyListWeatherWidget(forecastData: forecastData),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                )
              )
            )
          ],
        ),
      ),
    );
  }
}

