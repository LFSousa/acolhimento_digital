import 'package:acolhimento_digital/app/presentation/pages/map/map_page.dart';
import 'package:acolhimento_digital/app/presentation/pages/splash/splash.dart';
import 'package:auto_route/auto_route.dart';

import 'pages/welcome/welcome_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: WelcomePage),
    AutoRoute(page: MapPage),
  ],
)
class $AppRouter {}
