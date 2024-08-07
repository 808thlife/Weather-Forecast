import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_forecast/core/utils/handle_location_permissions.dart';
import 'dart:core';

import 'package:weather_forecast/network/api/api.dart';
import 'package:weather_forecast/pages/home_screen/provider/active_title_provider.dart';

class DailyWeatherScreen extends ConsumerStatefulWidget {
  const DailyWeatherScreen({super.key});

  @override
  ConsumerState<DailyWeatherScreen> createState() => _DailyWeatherScreenState();
}

class _DailyWeatherScreenState extends ConsumerState<DailyWeatherScreen> {
  Future<bool>? isLocationPermitted;

  @override
  void initState() {
    super.initState();
    isLocationPermitted = handleLocationPermission(context, mounted);

    Future(() {
      getWeatherData().then((value) {
        if (mounted) {
          ref.watch(titleProvider.notifier).overrideTitle(value["name"]);
        }
      });
    });
  }

  Future<Map<String, dynamic>> getWeatherData() async {
    final location = await getCurrentLocation();

    String lat = location[0].toStringAsFixed(2);
    String lon = location[1].toStringAsFixed(2);
    final response =
        await getTodayWeather(double.parse(lon), double.parse(lat), mounted);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLocationPermitted,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data == false) {
          return const Center(
            child: Text(
              "Please check the location permissions in the settings.",
              textAlign: TextAlign.center,
            ),
          );
        } else if (snapshot.hasError || !snapshot.hasData || !snapshot.data!) {
          return const Center(
            child: Text(
              "Something went wrong... Please try again later",
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return FutureBuilder<Map<String, dynamic>>(
            future: getWeatherData(),
            builder: (context, weatherSnapshot) {
              if (weatherSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (weatherSnapshot.hasError ||
                  !weatherSnapshot.hasData ||
                  weatherSnapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "Unable to get weather data. Please try again later.",
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                final weatherData = weatherSnapshot.data!;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        weatherData["weather"][0]["main"],
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 20),
                      ),
                      Image.asset(
                        "assets/weather_icons/cloudy_night.png",
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${weatherData["main"]["temp"].toString()} F, but feels like ${weatherData["main"]["feels_like"]} F",
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.wind_power_outlined),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                                "${weatherData["wind"]["speed"].toString()} m/s"),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
