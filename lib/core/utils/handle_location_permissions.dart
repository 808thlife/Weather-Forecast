import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:core';

Future<bool> handleLocationPermission(
    BuildContext context, bool mounted) async {
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
