import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_result_item_card.dart';
import 'package:clima_app/features/favorites/presentation/widgets/show_weather_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

class CitySearchResultsListWidget extends StatelessWidget {
  const CitySearchResultsListWidget({
    super.key,
    required this.cities,
  });

  final List<CityLocation> cities;

  Future<void> getWeatherSelected(
      {required CityLocation cityLocation,
      required BuildContext context}) async {
    _showWeatherBottomSheet(context, cityLocation: cityLocation);
  }

  void _showWeatherBottomSheet(
    BuildContext context, {
    required CityLocation cityLocation,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ShowWeatherBottomSheetWidget(
        cityLocation: cityLocation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => const SizedBox(height: 4),
        separatorBuilder: (context, index) {
          final cityLocation = cities[index];
          final cityName = cityLocation.city;
          final state = cityLocation.state;
          final country = cityLocation.country;

          final query = "$cityName, $state, $country";

          return GestureDetector(
            onTap: () => getWeatherSelected(
                cityLocation: cityLocation, context: context),
            child: CityResultItemCard(query: query),
          );
        },
        itemCount: cities.length);
  }
}
