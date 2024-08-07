import 'package:flutter/material.dart';
import 'package:weather_forecast/core/utils/handle_location_permissions.dart';
import 'package:weather_forecast/network/api/api.dart';
import 'package:weather_forecast/pages/home_screen/provider/active_title_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Container(
      child: TextButton(
        onPressed: () {
          _fetchForecast().then((value) {
            print(value);
          });
        },
        child: Text("Something"),
      ),
    );
  }
}
