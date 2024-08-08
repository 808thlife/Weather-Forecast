import 'package:flutter/material.dart';
import 'package:weather_forecast/pages/today_weather/widgets/weather_icon.dart';
import 'package:weather_forecast/pages/week_weather/widgets/part_of_day_icon.dart';

class WeekDayWeatherCard extends StatelessWidget {
  const WeekDayWeatherCard({super.key, required this.forecast});

  final Map<String, dynamic> forecast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Card(
        surfaceTintColor: Theme.of(context).cardTheme.surfaceTintColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  // child: PartOfDayIcon(
                  //   weather: forecast["weather"][0]["main"],
                  //   currentTime: DateTime.now(),
                  // ),
                  child: Text(forecast["dt_txt"]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
