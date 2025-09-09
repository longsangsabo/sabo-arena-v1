import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/custom_bottom_bar.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/club_profile_screen/club_profile_screen.dart';
import '../presentation/user_profile_screen/user_profile_screen.dart';
import '../presentation/find_opponent_screen/find_opponent_screen.dart';
import '../presentation/tournament_screen/tournament_screen.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;
  
  const MainLayout({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavigationChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          // 0: Trang chủ
          const HomeScreen(),
          
          // 1: Tìm đối
          const FindOpponentScreen(),
          
          // 2: Giải đấu
          const TournamentScreen(),
          
          // 3: Club
          const ClubProfileScreen(),
          
          // 4: Hồ sơ
          const UserProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onChanged: _onNavigationChanged,
      ),
    );
  }

  Widget _buildPlaceholderPage(String title, String description) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64.h,
              color: Colors.grey,
            ),
            SizedBox(height: 16.h),
            Text(
              description,
              style: TextStyle(
                fontSize: 18.fSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Đang phát triển...",
              style: TextStyle(
                fontSize: 14.fSize,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
