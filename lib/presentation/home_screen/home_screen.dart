import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import './home_screen_initial_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  // use for the bottom bar screen navigation
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.homeScreenInitialPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, a1, a2) =>
                getCurrentPage(context, routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.maxFinite,
        child: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      bottomBarItemList: [
        CustomBottomBarItem(
          icon: ImageConstant.imgNavTrangCh,
          title: 'Trang chủ',
          routeName: AppRoutes.homeScreenInitialPage,
          itemType: CustomBottomBarItemType.home,
          fontFamily: 'ABeeZee',
        ),
        CustomBottomBarItem(
          icon: ImageConstant.imgNavTmI,
          title: 'Tìm đối',
          routeName: '/search',
          iconHeight: 20.h,
          iconWidth: 20.h,
        ),
        CustomBottomBarItem(
          icon: '',
          title: 'Giải đấu',
          routeName: '/tournament',
          itemType: CustomBottomBarItemType.tournament,
          badgeCount: 8,
          unselectedTextColor: appTheme.gray_500,
        ),
        CustomBottomBarItem(
          icon: ImageConstant.imgClb,
          title: 'Club',
          routeName: '/club',
          iconHeight: 32.h,
          iconWidth: 32.h,
          selectedTextColor: appTheme.gray_800,
        ),
        CustomBottomBarItem(
          icon: ImageConstant.imgNavHS,
          title: 'Hồ sơ',
          routeName: '/profile',
          iconHeight: 20.h,
          iconWidth: 18.h,
          selectedTextColor: appTheme.gray_900,
        ),
      ],
      onChanged: (index) {
        var bottomBarItemList = [
          AppRoutes.homeScreenInitialPage,
          '/search',
          '/tournament',
          '/club',
          '/profile'
        ];
        navigatorKey.currentState?.pushNamed(bottomBarItemList[index]);
      },
      selectedIndex: 0,
      backgroundColor: appTheme.whiteCustom,
      shadowColor: appTheme.blue_gray_100,
      height: 70.h,
    );
  }

  ///Handling page based on route
  Widget getCurrentPage(BuildContext context, String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeScreenInitialPage:
        return HomeScreenInitialPage();
      default:
        return Container();
    }
  }
}
