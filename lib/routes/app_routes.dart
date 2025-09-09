import 'package:flutter/material.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/tournament_screen/tournament_screen.dart';
import '../presentation/club_screen/club_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';
import '../presentation/search_screen/search_screen.dart';
import '../presentation/find_opponent_screen/find_opponent_screen.dart';
import '../presentation/user_profile_screen/user_profile_screen.dart';
import '../presentation/club_profile_screen/club_profile_screen.dart';
// import '../presentation/auth/login_screen.dart';
import '../widgets/main_layout.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String homeScreen = '/home_screen';
  static const String tournamentScreen = '/tournament_screen';
  static const String clubScreen = '/club_screen';
  static const String profileScreen = '/profile_screen';
  static const String searchScreen = '/search_screen';
  static const String findOpponentScreen = '/find_opponent_screen';
  static const String userProfileScreen = '/user_profile_screen';
  static const String clubProfileScreen = '/club_profile_screen';
  // static const String loginScreen = '/login_screen';
  static const String mainLayout = '/main_layout';
  static const String homeScreenInitialPage = '/home_screen_initial_page';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/';

  static Map<String, WidgetBuilder> get routes => {
        homeScreen: (context) => HomeScreen(),
        tournamentScreen: (context) => const TournamentScreen(),
        clubScreen: (context) => const ClubScreen(),
        profileScreen: (context) => const ProfileScreen(),
        searchScreen: (context) => const SearchScreen(),
        findOpponentScreen: (context) => const FindOpponentScreen(),
        userProfileScreen: (context) => const UserProfileScreen(),
        clubProfileScreen: (context) => const ClubProfileScreen(),
        // loginScreen: (context) => const LoginScreen(),
        mainLayout: (context) => const MainLayout(),
        appNavigationScreen: (context) => AppNavigationScreen(),
        initialRoute: (context) => const MainLayout()
      };
}
