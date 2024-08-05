import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:core';

class DailyWeatherScreen extends StatefulWidget {
  const DailyWeatherScreen({super.key});

  @override
  State<DailyWeatherScreen> createState() => _DailyWeatherScreenState();
}

class _DailyWeatherScreenState extends State<DailyWeatherScreen> {
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
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text("Buttoning"),
                  onPressed: () {
                    final location = getCurrentLocation();
                    location.then((value) => print(value));
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
