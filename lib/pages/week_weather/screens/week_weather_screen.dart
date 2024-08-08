import 'package:flutter/material.dart';
import 'package:weather_forecast/core/utils/handle_location_permissions.dart';
import 'package:weather_forecast/network/api/api.dart';
import 'package:weather_forecast/pages/home_screen/provider/active_title_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_forecast/pages/week_weather/widgets/week_day_card.dart';
import 'package:weather_forecast/pages/week_weather/widgets/week_day_column.dart';

class WeekWeatherScreen extends ConsumerStatefulWidget {
  const WeekWeatherScreen({super.key});

  @override
  ConsumerState<WeekWeatherScreen> createState() => _WeekWeatherScreenState();
}

class _WeekWeatherScreenState extends ConsumerState<WeekWeatherScreen> {
  @override
  void initState() {
    super.initState();

    Future(
      () {
        ref.read(titleProvider.notifier).overrideTitle("Weather this week");
      },
    );
    _fetchForecast();
  }

  Future<Map<String, dynamic>> _fetchForecast() async {
    var isLocationPermitted = await handleLocationPermission(context, mounted);
    if (isLocationPermitted) {
      var currentLocation = await getCurrentLocation();
      double lon = currentLocation[0];
      double lat = currentLocation[1];

      var forecastData = await getForecast(lat, lon, mounted);
      return forecastData;
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchForecast(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.hasError) {
          return Center(
            child: Text(
              "Something went wrong. Please, try again later",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        } else {
          return Center(
            child: Expanded(
              child: WeekDayColumn(
                forecast: snapshot.data,
              ),
            ),
          );
        }
      },
    );
  }
}
