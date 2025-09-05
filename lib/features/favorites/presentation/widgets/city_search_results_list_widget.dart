import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_result_item_card.dart';
import 'package:clima_app/features/favorites/presentation/widgets/show_weather_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

class CitySearchResultsListWidget extends StatelessWidget {
  const CitySearchResultsListWidget({
    super.key,
    required this.result,
  });

  final List<CityLocation> result;

  Future<void> getWeatherSelected(
      {required double latitude,
      required double longitude,
      required String cityName,
      required BuildContext context}) async {
    _showWeatherBottomSheet(context,
        cityName: cityName, latitude: latitude, longitude: longitude);
  }

  void _showWeatherBottomSheet(
    BuildContext context, {
    required String cityName,
    required double latitude,
    required double longitude,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ShowWeatherBottomSheetWidget(
        cityName: cityName,
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => const SizedBox(height: 4),
        separatorBuilder: (context, index) {
          final currentLocationData = result[index];
          final cityName = currentLocationData.name;
          final state = currentLocationData.state;
          final country = currentLocationData.country;

          final query = "$cityName, $state, $country";

          return GestureDetector(
            onTap: () => getWeatherSelected(
                latitude: currentLocationData.lat,
                longitude: currentLocationData.lon,
                cityName: query,
                context: context),
            child: CityResultItemCard(query: query),
          );
        },
        itemCount: result.length);
  }
}
