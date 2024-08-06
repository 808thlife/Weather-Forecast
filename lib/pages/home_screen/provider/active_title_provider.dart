import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveTitleProvider extends StateNotifier<String> {
  ActiveTitleProvider() : super("Weather Forecast");

  void overrideTitle(String title) {
    state = title;
  }
}

// Create a provider for the state notifier.
final titleProvider = StateNotifierProvider<ActiveTitleProvider, String>((ref) {
  return ActiveTitleProvider();
});
