import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hba_management/core/routing/route_path.dart';
import 'package:hba_management/layers/view/home_page.dart';
import 'package:hba_management/layers/view/hotel/create_hotel.dart';
import 'package:hba_management/layers/view/hotel/hotels.dart';

import '../../layers/view/intro/splash_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.LogIn:
        return MaterialPageRoute(builder: (_) => const Scaffold());
      case RoutePaths.SplashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case RoutePaths.HotelsScreen:
        return MaterialPageRoute(builder: (_) => HotelsScreen());
      case RoutePaths.CreateHotelScreen:
        return MaterialPageRoute(builder: (_) => CreateHotelScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
                // child: Text('No route defined for ${settings.name}'),
                ),
          ),
        );
    }
  }
}
