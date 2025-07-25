import 'package:clima_app/core/dio_client.dart';
import 'package:clima_app/features/city/data/repositories/city_repository_impl.dart';
import 'package:clima_app/features/city/domain/usecases/get_city_usecase.dart';
import 'package:clima_app/features/city/infrastructure/datasources/city_datasource_impl.dart';
import 'package:clima_app/features/city/domain/usecases/search_city_usecase.dart';
import 'package:clima_app/features/city/presentation/blocs/city_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/cubits/theme_cubit.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_items_list.dart';
import 'package:clima_app/features/favorites/presentation/pages/weather_list_favorites.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWeatherPage extends StatefulWidget {
  const HomeWeatherPage({super.key});

  @override
  State<HomeWeatherPage> createState() => _HomeWeatherPageState();
}

class _HomeWeatherPageState extends State<HomeWeatherPage> {
  late ThemeCubit themeCubit;

  @override
  void initState() {
    super.initState();
    themeCubit = context.read<ThemeCubit>();
  }

  Future<T?> pushWithSlideUp<T>(
    BuildContext context,
    Widget page, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child,
          );
        },
      ),
      predicate ?? (route) => false,
    );
  }

  Future<void> navigateToFavorites(BuildContext context) async {
    final dio = DioClient().dio;
    final dataSource = CityDataSourceImpl(dio: dio);
    final repository = CityRepositoryImpl(dataSource: dataSource);
    await pushWithSlideUp(
        context,
        BlocProvider(
          create: (context) => CityBloc(
              useCase: SearchCityUseCase(repository: repository),
              getCityUseCase: GetCityUseCase(repository: repository)),
          child: const WeatherListFavorites(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final backgroundWeatherCubit = context.watch<BackgroundWeatherCubit>();
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: backgroundWeatherCubit.state,
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            const Expanded(child: SizedBox.shrink()),
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                color: Colors.white.withOpacity(0.8),
                icon: const Icon(CupertinoIcons.line_horizontal_3),
                onPressed: () => navigateToFavorites(context),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        color: backgroundWeatherCubit.state,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(themeCubit.state.isDarkMode
                    ? Icons.sunny
                    : Icons.nightlight),
                color: theme.colorScheme.onPrimary,
                onPressed: () => themeCubit.toggleTheme(),
              ),
              const WeatherItemsList()
            ],
          ),
        ),
      ),
    );
  }
}
