import 'package:flutter_dotenv/flutter_dotenv.dart';

void getTodayWeather(double lon, double lat) {
  final String? key = dotenv.env['OPENWEATHER_API_KEY'];
  print("executed");
  print(key);
  print("HERE EEEEE");

  final String url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$key";
}
