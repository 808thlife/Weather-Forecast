import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon(
      {super.key, required this.weather, required this.currentTime});

  final String weather;
  final DateTime currentTime;

  @override
  Widget build(BuildContext context) {
    switch (weather) {
      case "Clear":
        if (TimeOfDay.now().hour > 12 && TimeOfDay.now().hour < 19) {
          return Image.asset("assets/weather_icons/clean.png");
        } else {
          return Image.asset("assets/weather_icons/moon_clean.png");
        }
      case "Clouds":
        if (TimeOfDay.now().hour > 12 && TimeOfDay.now().hour < 19) {
          return Image.asset("assets/weather_icons/cloudy_day.png");
        } else {
          return Image.asset("assets/weather_icons/moon_cloud.png");
        }
      case "Rain":
        return Image.asset("assets/weather_icons/showers_rain.png");

      case "Snow":
        return Image.asset("assets/weather_icons/snow.png");

      case "Mist" || "Smoke" || "Haze" || "Fog" || "Ash":
        return Image.asset("assets/weather_icons/mist-and-cloud.png");

      case "Squall":
        return Image.asset("assets/weather_icons/showers_rain.png");

      case "Tornado":
        return Image.asset("asset/weather_icons/tornado.png");

      case "Dust" || "Sand":
        if (TimeOfDay.now().hour > 12 && TimeOfDay.now().hour < 19) {
          return Image.asset("assets/weather_icon/dust_sun.png");
        } else {
          return Image.asset("assets/weather_icon/dust_moon.png");
        }

      default:
    }
    return SizedBox();
  }
}
