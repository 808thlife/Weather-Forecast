import 'package:flutter/material.dart';

class PartOfDayIcon extends StatelessWidget {
  const PartOfDayIcon(
      {super.key, required this.weather, required this.currentTime});

  final String weather;
  final DateTime currentTime;

  @override
  Widget build(BuildContext context) {
    switch (weather) {
      case "Clear":
        if (TimeOfDay.now().hour > 12 && TimeOfDay.now().hour < 19) {
          return Image.asset(
            "assets/weather_icons/clean.png",
            height: 40,
            width: 40,
            fit: BoxFit.scaleDown,
          );
        } else {
          return Image.asset(
            "assets/weather_icons/moon_clean.png",
            height: 40,
            width: 40,
            fit: BoxFit.scaleDown,
          );
        }
      case "Clouds":
        if (TimeOfDay.now().hour > 12 && TimeOfDay.now().hour < 19) {
          return Image.asset(
            "assets/weather_icons/cloudy_day.png",
            height: 40,
            width: 40,
            fit: BoxFit.scaleDown,
          );
        } else {
          return Image.asset(
            "assets/weather_icons/moon_cloud.png",
            height: 40,
            width: 40,
            fit: BoxFit.scaleDown,
          );
        }
      case "Rain":
        return Image.asset(
          "assets/weather_icons/showers_rain.png",
          height: 40,
          width: 40,
          fit: BoxFit.scaleDown,
        );

      case "Snow":
        return Image.asset(
          "assets/weather_icons/snow.png",
          height: 40,
          width: 40,
          fit: BoxFit.scaleDown,
        );

      case "Mist" || "Smoke" || "Haze" || "Fog" || "Ash":
        return Image.asset(
          "assets/weather_icons/mist-and-cloud.png",
          height: 40,
          width: 40,
          fit: BoxFit.scaleDown,
        );

      case "Squall":
        return Image.asset(
          "assets/weather_icons/showers_rain.png",
          height: 40,
          width: 40,
          fit: BoxFit.scaleDown,
        );

      case "Tornado":
        return Image.asset(
          "asset/weather_icons/tornado.png",
          height: 40,
          width: 40,
          fit: BoxFit.scaleDown,
        );

      case "Dust" || "Sand":
        if (TimeOfDay.now().hour > 12 && TimeOfDay.now().hour < 19) {
          return Image.asset(
            "assets/weather_icon/dust_sun.png",
            height: 40,
            width: 40,
            fit: BoxFit.scaleDown,
          );
        } else {
          return Image.asset(
            "assets/weather_icon/dust_moon.png",
            height: 40,
            width: 40,
            fit: BoxFit.scaleDown,
          );
        }

      default:
    }
    return SizedBox();
  }
}
