import 'dart:async';

import 'package:clima_app/features/home/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCityWidget extends StatefulWidget {
  const SearchCityWidget({
    super.key,
  });

  @override
  State<SearchCityWidget> createState() => _SearchCityWidgetState();
}

class _SearchCityWidgetState extends State<SearchCityWidget> {

  Timer? _debounce;
  late WeatherBloc _cityWeatherBloc;

  @override
  void initState() {
    _cityWeatherBloc = context.read<WeatherBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return CupertinoTextField(
      onChanged: (value) {
        if (_debounce?.isActive ?? false) _debounce!.cancel();

        _debounce = Timer(const Duration(milliseconds: 500), () {
          _cityWeatherBloc.add(SearchCityEvent(query: value));
        });
      },
      prefix: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Icon(
          CupertinoIcons.search,
          color: CupertinoColors.systemGrey.withOpacity(0.5),
        ),
      ),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          CupertinoIcons.mic,
          color: CupertinoColors.systemGrey.withOpacity(0.5),
        ),
      ),
      decoration: BoxDecoration(
          color: CupertinoColors.systemGrey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      placeholder: 'Search for a city or a airport',
      placeholderStyle: TextStyle(
        color: theme.colorScheme.onPrimary
      ),
    );
  }
}
