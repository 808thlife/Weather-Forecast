import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
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
    isLocationPermitted = _handleLocationPermission();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Location services are disabled. Please enable the services'),
          action: SnackBarAction(
              label: "Settings",
              onPressed: () {
                openAppSettings();
              }),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Location permissions are denied'),
          action: SnackBarAction(
              label: "Settings",
              onPressed: () {
                openAppSettings();
              }),
        ));

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever && mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Location permissions are permanently denied, we cannot request permissions.'),
          action: SnackBarAction(
              label: "Settings",
              onPressed: () {
                openAppSettings();
              }),
        ),
      );
      return false;
    }
    return true;
  }

  Future<List<double>> getCurrentLocation() async {
    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    return [location.latitude, location.longitude].toList();
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
    getWeatherData().then((value) {
      if (mounted) {
        ref.read(titleProvider.notifier).overrideTitle(value["name"]);
      }
    });

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
                print(weatherData);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        weatherData["weather"][0]["main"],
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 20),
                      ),
                      Image.asset(
                        "assets/weather_icons/mist-and-cloud.png",
                        color: Colors.white,
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
