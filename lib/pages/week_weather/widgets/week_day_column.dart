import 'package:flutter/material.dart';
import 'package:weather_forecast/pages/week_weather/widgets/week_day_card.dart';

class WeekDayColumn extends StatelessWidget {
  const WeekDayColumn({super.key, required this.forecast});

  final Map<String, dynamic>? forecast;

  @override
  Widget build(BuildContext context) {
    // print(forecast!.length);
    return ListView.builder(
      itemCount: forecast!.length,
      itemBuilder: (ctx, index) =>
          WeekDayWeatherCard(forecast: forecast!["list"][index]),
    );
  }
}
