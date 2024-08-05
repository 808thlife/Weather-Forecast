import 'package:flutter/material.dart';
import 'package:weather_forecast/pages/today_weather/screens/daily_weather_screen.dart';
import 'package:weather_forecast/pages/week_weather/screens/week_weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          title: Text(_activeTitle),
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
