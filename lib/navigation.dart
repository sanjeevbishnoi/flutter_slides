import 'package:flutter_web/material.dart';
import 'package:tk.slides/routes/bad_route.dart';
import 'package:tk.slides/routes/animated_slide.dart';

class Navigation {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AnimatedSlide.routeName:
        return MaterialPageRoute(
          builder: (_) => AnimatedSlide(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BadRoute(routeName: settings.name),
        );
    }
  }
}
