import 'package:flutter/material.dart';

class ShowWeatherPage extends StatefulWidget {
  const ShowWeatherPage({super.key});

  @override
  State<ShowWeatherPage> createState() => _ShowWeatherPageState();
}

class _ShowWeatherPageState extends State<ShowWeatherPage> {
  @override
  Widget build(BuildContext context) {

    final forecastData = [
      {'hour': 'Now', 'icon': Icons.wb_sunny, 'rain': '14%', 'wind': '4 m/s'},
      {'hour': '16:00', 'icon': Icons.cloud, 'rain': '37%', 'wind': '7 m/s'},
      {'hour': '17:00', 'icon': Icons.wb_sunny, 'rain': '23%', 'wind': '4 m/s'},
      {'hour': '18:00', 'icon': Icons.cloud, 'rain': '45%', 'wind': '6 m/s'},
      {'hour': '19:00', 'icon': Icons.cloudy_snowing, 'rain': '75%', 'wind': '7 m/s'},
    ];

    return Scaffold(
      body: Container(
        color: Colors.blue,
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
                        const Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("City",
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white
                                ),
                              ),
                            ),
                            Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 40,
                            )
                          ],
                        ),
                        const SizedBox(height: 8,),
                        const Text(
                          "Wed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                          )
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "26 °C",
                                style: TextStyle(
                                  fontSize: 80,
                                  color: Colors.white
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '26°',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  width: 40,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                const Text(
                                  '16°',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ...forecastData.map((data) {
                                return Column(
                                  children: [
                                    Text("${data['hour']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Icon(data['icon'] as IconData, size: 28, color: Colors.blueAccent),
                                    const SizedBox(height: 4),
                                    Column(
                                      children: [
                                        const Icon(Icons.water_drop_outlined, size: 16, color: Colors.blue),
                                        Text("${data['rain']}", style: const TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Column(
                                      children: [
                                        const Icon(Icons.air, size: 16, color: Colors.blueGrey),
                                        Text("${data['wind']}", style: const TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                );
                              })
                            ],
                          ),
                        )
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
