import 'package:flutter/material.dart';
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

    Future(() {
      ref.read(titleProvider.notifier).overrideTitle("Weather this week");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Text("Something even more and more"),
        ],
      ),
    );
  }
}
