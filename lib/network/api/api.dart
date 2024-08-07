import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getTodayWeather(
    double lon, double lat, bool mounted) async {
  final String? key = dotenv.env['OPENWEATHER_API_KEY'];

  final String url =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$key";

  final response = await http.get(Uri.parse(url));

  if (mounted && response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  return {};
}

Future<void> getWeekData(double lon, double lat, bool mounted) async {
  final String? key = dotenv.env['OPENWEATHER_API_KEY'];
  final String url =
      "api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$key";

  final response = await http.get(Uri.parse(url));

  if (mounted && response.statusCode == 200) {
    print(jsonDecode(response.body));
  }
}
