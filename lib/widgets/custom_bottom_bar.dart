import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * CustomBottomBar - A flexible bottom navigation bar component with support for special items like tournaments with badges and gradients
 * 
 * @param bottomBarItemList - List of bottom bar items to display
 * @param onChanged - Callback function when an item is tapped, returns the index
 * @param selectedIndex - Currently selected item index (default: 0)
 * @param backgroundColor - Background color of the bottom bar (default: white)
 * @param shadowColor - Shadow color for the bottom bar (default: #d0d1d3)
 * @param height - Height of the bottom bar (default: 70)
 */
class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({
    Key? key,
    required this.bottomBarItemList,
    required this.onChanged,
    this.selectedIndex = 0,
    this.backgroundColor,
    this.shadowColor,
    this.height,
  }) : super(key: key);

  final List<CustomBottomBarItem> bottomBarItemList;
  final Function(int) onChanged;
  final int selectedIndex;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 70.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? appTheme.whiteCustom,
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Color(0xFFD0D1D3),
            blurRadius: 1.h,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(bottomBarItemList.length, (index) {
            final item = bottomBarItemList[index];
            final isSelected = selectedIndex == index;

            return Expanded(
              child: InkWell(
                onTap: () => onChanged(index),
                child: _buildBottomBarItem(item, isSelected),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBottomBarItem(CustomBottomBarItem item, bool isSelected) {
    if (item.itemType == CustomBottomBarItemType.tournament) {
      return _buildTournamentItem(item, isSelected);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 6.h),
        CustomImageView(
          imagePath: isSelected ? (item.activeIcon ?? item.icon) : item.icon,
          height: item.iconHeight ?? 20.h,
          width: item.iconWidth ?? 20.h,
        ),
        SizedBox(
            height: item.itemType == CustomBottomBarItemType.home ? 4.h : 2.h),
        Text(
          item.title,
          style: TextStyleHelper.instance.label10Regular.copyWith(
              color: isSelected
                  ? (item.selectedTextColor ?? Color(0xFF161722))
                  : (item.unselectedTextColor ?? Color(0xFF8A8B8F))),
        ),
      ],
    );
  }

  Widget _buildTournamentItem(CustomBottomBarItem item, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              width: 42.h,
              height: 28.h,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 36.h,
                      height: 28.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.h),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF3C0B43), Color(0xFFE220FD)],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 36.h,
                      height: 28.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.h),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF6987DE), Color(0xFF081E5F)],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.h),
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(
                      color: appTheme.whiteCustom,
                      borderRadius: BorderRadius.circular(8.h),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (item.badgeCount != null && item.badgeCount! > 0)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.h),
                              gradient: LinearGradient(
                                begin: Alignment(0.34, -0.94),
                                end: Alignment(-0.34, 0.94),
                                colors: [Color(0xFF1A1919), Color(0xFF000000)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: appTheme.color990000,
                                  blurRadius: 8.h,
                                ),
                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2.h),
                              decoration: BoxDecoration(
                                color: appTheme.whiteCustom,
                                borderRadius: BorderRadius.circular(6.h),
                              ),
                              child: Text(
                                '${item.badgeCount}',
                                style: TextStyleHelper
                                    .instance.label8RegularABeeZee,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Text(
          item.title,
          style: TextStyleHelper.instance.label10RegularRambla.copyWith(
              color: isSelected
                  ? (item.selectedTextColor ?? Color(0xFF161722))
                  : (item.unselectedTextColor ?? Color(0xFFA1A2A5))),
        ),
      ],
    );
  }
}

enum CustomBottomBarItemType {
  normal,
  home,
  tournament,
}

class CustomBottomBarItem {
  CustomBottomBarItem({
    required this.icon,
    required this.title,
    required this.routeName,
    this.activeIcon,
    this.iconHeight,
    this.iconWidth,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.fontFamily,
    this.itemType = CustomBottomBarItemType.normal,
    this.badgeCount,
  });

  final String icon;
  final String? activeIcon;
  final String title;
  final String routeName;
  final double? iconHeight;
  final double? iconWidth;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final String? fontFamily;
  final CustomBottomBarItemType itemType;
  final int? badgeCount;
}
