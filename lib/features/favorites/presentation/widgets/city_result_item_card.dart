import 'package:flutter/material.dart';

class CityResultItemCard extends StatelessWidget {
  const CityResultItemCard({
    super.key,
    required this.cityName,
    required this.state,
    required this.country,
  });

  final String cityName;
  final String? state;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 8.0),
      child: Text("$cityName, $state, $country"),
    );
  }
}