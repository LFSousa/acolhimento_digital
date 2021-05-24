// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import 'pages/map/map_page.dart' as _i5;
import 'pages/splash/splash.dart' as _i3;
import 'pages/welcome/welcome_page.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<SplashRouteArgs>(
              orElse: () => const SplashRouteArgs());
          return _i3.SplashPage(key: args.key);
        }),
    WelcomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.WelcomePage();
        }),
    MapRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.MapPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashRoute.name, path: '/'),
        _i1.RouteConfig(WelcomeRoute.name, path: '/welcome-page'),
        _i1.RouteConfig(MapRoute.name, path: '/map-page')
      ];
}

class SplashRoute extends _i1.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({_i2.Key? key})
      : super(name, path: '/', args: SplashRouteArgs(key: key));

  static const String name = 'SplashRoute';
}

class SplashRouteArgs {
  const SplashRouteArgs({this.key});

  final _i2.Key? key;
}

class WelcomeRoute extends _i1.PageRouteInfo {
  const WelcomeRoute() : super(name, path: '/welcome-page');

  static const String name = 'WelcomeRoute';
}

class MapRoute extends _i1.PageRouteInfo {
  const MapRoute() : super(name, path: '/map-page');

  static const String name = 'MapRoute';
}
