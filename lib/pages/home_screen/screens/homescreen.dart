import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_forecast/pages/home_screen/provider/active_title_provider.dart';
import 'package:weather_forecast/pages/today_weather/screens/daily_weather_screen.dart';
import 'package:weather_forecast/pages/week_weather/screens/week_weather_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  String _activeTitle = "Today Weather";

  static const List<Widget> _widgetOptions = <Widget>[
    DailyWeatherScreen(),
    WeekWeatherScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        _activeTitle = "Today Weather";
      } else {
        _activeTitle = "This Week's Weather";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(ref.watch(titleProvider)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: "Today's weather",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_week_outlined),
              label: "Weather this week",
            ),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
