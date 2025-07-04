import 'package:clima_app/features/search/presentation/widgets/daily_list_weather_widget.dart';
import 'package:clima_app/features/search/presentation/widgets/header_weather_widget.dart';
import 'package:clima_app/features/search/presentation/widgets/hourly_list_weather_widget.dart';
import 'package:flutter/material.dart';

class ShowWeatherPage extends StatefulWidget {
  const ShowWeatherPage({super.key});

  @override
  State<ShowWeatherPage> createState() => _ShowWeatherPageState();
}

class _ShowWeatherPageState extends State<ShowWeatherPage> {
  @override
  Widget build(BuildContext context) {

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
        color: Colors.blue[300],
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
                            Icon(
                              Icons.menu,
                              color: theme.colorScheme.onPrimary,
                              size: 40,
                            )
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Text(
                          "Wed",
                          style: theme.textTheme.bodyMedium
                        ),
                        const HeaderWeatherWidget(temp: 26),
                        HourlyListWeatherWidget(forecastData: forecastData),
                        const SizedBox(height: 24),
                        DailyListWeatherWidget(forecastData: forecastData),
                        const SizedBox(height: 10,)
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

