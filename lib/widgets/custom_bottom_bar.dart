import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'custom_image_view.dart';

/// Constants for bottom navigation styling
class _BottomNavConstants {
  static const double navHeight = 70.0;
  static const double iconSize = 20.0;
  static const double tournamentIconSize = 34.0;
  static const double iconSpacing = 4.0;
  static const double labelFontSize = 10.0;
  static const double badgeFontSize = 8.0;
  static const double letterSpacing = 0.15;
  
  // Tournament center item layout
  static const double centerWidth = 70.0;
  static const double centerHeight = 50.0;
  static const double gradientWidth = 36.0;
  static const double gradientHeight = 28.0;
  static const double purpleLeft = 22.0;
  static const double blueLeft = 15.0;
  static const double whiteLeft = 18.5;
  static const double badgeLeft = 26.0;
  static const double gradientTop = 4.0;
  static const double badgeTop = 6.0;
  static const double badgeSize = 24.0;
  static const double badgeInnerSize = 12.0;
  static const double iconInCenterSize = 20.0;
}

/// Shared text styles for bottom navigation
class _BottomNavStyles {
  static TextStyle labelStyle({
    required Color color,
    required String fontFamily,
  }) => TextStyle(
    color: color,
    fontSize: _BottomNavConstants.labelFontSize,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    letterSpacing: _BottomNavConstants.letterSpacing,
    decoration: TextDecoration.none,
  );
  
  static const TextStyle badgeStyle = TextStyle(
    color: Colors.black,
    fontSize: _BottomNavConstants.badgeFontSize,
    fontFamily: 'ABeeZee',
    fontWeight: FontWeight.w400,
  );
}

// Auto-configured navigation item data class
class BottomNavItem {
  final String icon;
  final String title;
  final String fontFamily;
  final Color color;
  final Color? selectedColor;
  final bool showBadge;
  final int badgeCount;
  final double iconSize;

  const BottomNavItem({
    required this.icon,
    required this.title,
    this.fontFamily = 'Rambla',
    required this.color,
    this.selectedColor,
    this.showBadge = false,
    this.badgeCount = 0,
    this.iconSize = 20,
  });
}

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onChanged;
  final int tournamentBadge;

  const CustomBottomBar({
    Key? key,
    required this.selectedIndex,
    this.onChanged,
    this.tournamentBadge = 8, // default giống ví dụ
  }) : super(key: key);

  // Điều chỉnh list item (trừ item giữa sẽ custom riêng)
  static final List<BottomNavItem> _navItems = [
    BottomNavItem(
      icon: ImageConstant.imgHomeStroke,
      title: 'Trang chủ',
      fontFamily: 'ABeeZee',
      color: const Color(0xFF8A8B8F),
      selectedColor: Colors.black,
    ),
    BottomNavItem(
      icon: ImageConstant.imgSearch,
      title: 'Tìm đối',
      fontFamily: 'Rambla',
      color: const Color(0xFF8A8B8F),
      selectedColor: Colors.black,
    ),
    // index 2: Tournament (center item with hidden label)
    BottomNavItem(
      icon: ImageConstant.imgTournament,
      title: 'Giải đấu',
      fontFamily: 'Rambla',
      color: const Color(0xFFA1A2A5),
      selectedColor: const Color(0xFFA1A2A5),
      iconSize: 34,
      showBadge: true,
    ),
    BottomNavItem(
      icon: ImageConstant.imgClbIcon,
      title: 'Club',
      fontFamily: 'Rambla',
      color: const Color(0xFF45454E),
      selectedColor: Colors.black,
    ),
    BottomNavItem(
      icon: ImageConstant.imgAccountSolid,
      title: 'Hồ sơ',
      fontFamily: 'Rambla',
      color: const Color(0xFF8A8B8F),
      selectedColor: const Color(0xFF161722),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        width: double.infinity,
        height: _BottomNavConstants.navHeight.h,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD0D1D3),
            blurRadius: 0,
            offset: Offset(0, -0.33),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(_navItems.length, (index) {
          if (index == 2) {
            return Expanded(
              child: _TournamentCenterItem(
                item: _navItems[index],
                badge: tournamentBadge,
                isSelected: selectedIndex == index,
                onTap: () => onChanged?.call(index),
              ),
            );
          }
          final item = _navItems[index];
          return Expanded(
            child: _StandardNavItem(
              item: item,
              isSelected: selectedIndex == index,
              onTap: () => onChanged?.call(index),
            ),
          );
        }),
      ),
    ));
  }
}

// Item tiêu chuẩn (không phải trung tâm)
class _StandardNavItem extends StatelessWidget {
  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  const _StandardNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isSelected && item.selectedColor != null
        ? item.selectedColor!
        : item.color;
    return Semantics(
      label: item.title,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: item.icon,
            height: item.iconSize.h,
            width: item.iconSize.h,
            color: item.icon.endsWith('tournament_icon.svg')
                ? null
                : effectiveColor,
          ),
          SizedBox(height: _BottomNavConstants.iconSpacing.h),
          Text(
            item.title,
            style: _BottomNavStyles.labelStyle(
              color: effectiveColor,
              fontFamily: item.fontFamily,
            ),
          )
        ],
      ),
    ));
  }
}

// Item trung tâm "Giải đấu" mô phỏng layout tuyệt đối trong yêu cầu
class _TournamentCenterItem extends StatelessWidget {
  final BottomNavItem item;
  final int badge;
  final bool isSelected;
  final VoidCallback onTap;
  const _TournamentCenterItem({
    required this.item,
    required this.badge,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: badge > 0 ? '${item.title}, $badge thông báo mới' : item.title,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Layer nền như đoạn code cố định (dùng Align + Positioned bên trong SizedBox cố định)
            SizedBox(
              width: _BottomNavConstants.centerWidth.w,
              height: _BottomNavConstants.centerHeight.h,
              child: Stack(
                children: [
                  // Gradient tím (lớp trên cùng)
                  Positioned(
                    left: 22.w,
                    top: 4.h,
                    child: Container(
                      width: 36.w,
                      height: 28.h,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.5, 0.0),
                          end: Alignment(0.5, 1.0),
                          colors: [Color(0xFF3C0B43), Color(0xFFE220FD)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  // Gradient xanh dịch sang trái
                  Positioned(
                    left: 15.w,
                    top: 4.h,
                    child: Container(
                      width: 36.w,
                      height: 28.h,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.5, 0.0),
                          end: Alignment(0.5, 1.0),
                          colors: [Color(0xFF6987DE), Color(0xFF081E5F)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  // Lớp trắng nằm giữa (tạo cảm giác viền 2 màu)
                  Positioned(
                    left: 18.5.w,
                    top: 4.h,
                    child: Container(
                      width: 36.w,
                      height: 28.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: CustomImageView(
                        imagePath: item.icon,
                        height: 20.h,
                        width: 20.h,
                      ),
                    ),
                  ),
                  // Badge theo mẫu (gradient tròn + số 8)
                  if (badge > 0)
                    Positioned(
                      left: 26.w,
                      top: 6.h,
                      child: Container(
                        width: 24.h,
                        height: 24.h,
                        decoration: const ShapeDecoration(
                          gradient: RadialGradient(
                            center: Alignment(0.5, 0.5),
                            radius: 1.31,
                            colors: [Color(0xFF1A1919), Colors.black],
                          ),
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x99000000),
                              blurRadius: 8,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 12.h,
                            height: 12.h,
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: OvalBorder(),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              badge.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontFamily: 'ABeeZee',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Label ẩn cho item tournament (chỉ hiển thị icon + badge)
          ],
        ),
      ),
    ));
  }
}

// Bottom bar types enum for navigation
enum BottomBarEnum {
  home,
  findOpponent,
  tournament,
  club,
  profile,
}

class BottomMenuModel {
  String icon;
  String? activeIcon;
  String title;
  String type;
  Function()? onTap;

  BottomMenuModel({
    required this.icon,
    this.activeIcon,
    required this.title,
    required this.type,
    this.onTap,
  });
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.h),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please replace the respective Widget here",
              style: TextStyle(
                fontSize: 18.fSize,
              ),
            )
          ],
        ),
      ),
    );
  }
}
