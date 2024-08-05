import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

void getTodayWeather(double lon, double lat) async {
  final String? key = dotenv.env['OPENWEATHER_API_KEY'];
  print("executed");
  print(key);
  print("HERE EEEEE");
  //"https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$key";
//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=
  final String url =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$key";

  print(url);
  final response = await http.get(Uri.parse(url));
  print(response.body);
}
