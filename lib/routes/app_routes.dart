import 'package:flutter/material.dart';
import '../presentation/home_screen/home_screen.dart';
import '../widgets/main_layout.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String homeScreen = '/home_screen';
  static const String mainLayout = '/main_layout';
  static const String homeScreenInitialPage = '/home_screen_initial_page';

  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/';

  static Map<String, WidgetBuilder> get routes => {
        homeScreen: (context) => HomeScreen(),
        mainLayout: (context) => const MainLayout(),
        appNavigationScreen: (context) => AppNavigationScreen(),
        initialRoute: (context) => const MainLayout()
      };
}
