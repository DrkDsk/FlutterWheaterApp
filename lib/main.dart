import 'package:clima_app/features/search/data/models/location_model.dart';
import 'package:clima_app/features/search/data/models/request_model.dart';
import 'package:flutter/material.dart';

import 'features/search/data/models/air_quality_model.dart';
import 'features/search/data/models/astro_model.dart';
import 'features/search/data/models/current_model.dart';
import 'features/search/data/models/search_response_model.dart';

void main() {
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

  final result = SearchResponseModel.fromJson(json);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
