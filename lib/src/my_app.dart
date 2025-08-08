import 'package:clima_app/core/shared/widgets/welcome_screen.dart';
import 'package:clima_app/core/theme/light_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      title: 'App del clima',
      home: const WelcomeScreen(),
    );
  }
}
