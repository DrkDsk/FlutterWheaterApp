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
                        const Row(
                          children: [
                            Icon(
                              Icons.sunny,
                              color: Colors.amber,
                              size: 70,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "26 °C",
                                style: TextStyle(
                                  fontSize: 80,
                                  color: Colors.white
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ...forecastData.map((data) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 18),
                                    child: Column(
                                      children: [
                                        Text("${data['hour']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 12),
                                        Icon(data['icon'] as IconData, size: 28, color: Colors.blueAccent),
                                        const SizedBox(height: 12),
                                        Column(
                                          children: [
                                            const Icon(Icons.water_drop_outlined, size: 16, color: Colors.blue),
                                            Text("${data['rain']}", style: const TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Column(
                                          children: [
                                            const Icon(Icons.air, size: 16, color: Colors.blueGrey),
                                            Text("${data['wind']}", style: const TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.white
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...forecastData.map((data) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(child: Text("${data['hour']}", style: const TextStyle(fontWeight: FontWeight.bold))),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.water_drop_outlined, size: 16, color: Colors.blue),
                                                Text("${data['rain']}", style: const TextStyle(fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.air, size: 16, color: Colors.blueGrey),
                                                Text("${data['wind']}", style: const TextStyle(fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                          Expanded(child: Icon(data['icon'] as IconData, size: 28, color: Colors.blueAccent)),
                                          Expanded(child: Text("${data['temp']}°C")),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
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
