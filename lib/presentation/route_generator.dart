import 'package:flutter/material.dart';
import 'package:journey_share/presentation/screens/authenticated/feed/feed-screen.dart';
import 'package:journey_share/presentation/screens/authenticated/upload/screens/add_details_screen.dart';
import 'package:journey_share/presentation/screens/non_authenticated/login/login-screen.dart';
import 'package:journey_share/presentation/screens/root_screen.dart';
import 'package:journey_share/presentation/widgets/screen_wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/auth':
        return MaterialPageRoute(
            builder: (_) => const ScreenWrapper(child: LoginScreen()));
      case '/feed':
        return MaterialPageRoute(
            builder: (_) => ScreenWrapper(child: RootScreen()));
      case '/upload':
        return MaterialPageRoute(
            builder: (_) => ScreenWrapper(child: RootScreen()));
      case '/upload/details':
        return MaterialPageRoute(
            builder: (_) => ScreenWrapper(child: AddDetailsScreen()));
      default:
        return _errorMessage();
    }
  }

  static MaterialPageRoute _errorMessage() =>
      MaterialPageRoute(builder: (_) => Text('Something went wrong!'));
}
