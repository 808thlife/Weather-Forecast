import 'package:flutter/material.dart';
import 'package:weather_forecast/pages/home_screen/screens/homescreen.dart';
import 'config/theme/util.dart';
import 'config/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  runApp(const MyApp());
  await dotenv.load(fileName: ".env");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme =
        createTextTheme(context, "Space Grotesk", "Space Mono");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const HomeScreen(),
    );
  }
}
