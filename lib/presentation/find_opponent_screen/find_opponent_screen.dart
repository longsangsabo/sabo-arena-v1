import 'package:flutter/material.dart';
import 'dart:ui';
import '../../core/app_export.dart';

class FindOpponentScreen extends StatelessWidget {
  const FindOpponentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Blurred background with user image
          _buildBlurredBackground(),
          
          // Top header with SABO branding
          _buildTopHeader(),
          
          // Tabs (Giao lưu | Thách đấu)
          _buildTabs(),
          
          // Main user profile card
          _buildUserProfileCard(),
          
          // Rank badge
          _buildRankBadge(),
          
          // Small avatar with online indicator
          _buildSmallAvatar(),
          
          // Right side interaction buttons
          _buildInteractionButtons(),
          
          // Bottom user info
          _buildBottomUserInfo(),
        ],
      ),
    );
  }

  Widget _buildBlurredBackground() {
    return Positioned.fill(
      child: Stack(
        children: [
          // User avatar as background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://placehold.co/414x813"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blur overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader() {
    return Positioned(
      left: 1.h,
      top: 50.h,
      child: Container(
        width: 413.h,
        height: 34.h,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                'SABO',
                style: TextStyle(
                  color: const Color(0xFF6403C8),
                  fontSize: 24.fSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                  height: 1.33,
                  letterSpacing: 1.20,
                ),
              ),
            ),
            Spacer(),
            // Icons on the right
            Row(
              children: [
                Icon(Icons.search, color: Colors.white, size: 20.h),
                SizedBox(width: 26.h),
                Icon(Icons.favorite, color: Colors.white, size: 20.h),
                SizedBox(width: 26.h),
                Icon(Icons.person, color: Colors.white, size: 20.h),
                SizedBox(width: 20.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Positioned(
      left: 0,
      top: 77.h,
      child: Container(
        width: 414.h,
        height: 44.h,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Giao lưu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.fSize,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Thách đấu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFCCCCCE),
                    fontSize: 16.fSize,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileCard() {
    return Positioned(
      left: 60.h,
      top: 121.h,
      child: Container(
        width: 299.h,
        height: 293.58.h,
        padding: EdgeInsets.all(2.h),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.33, -0.17),
            end: Alignment(0.67, 1.17),
            colors: [
              Color(0x667784F8),
              Color(0x331B1A26),
              Color(0x66C695F8),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.h),
          ),
        ),
        child: Container(
          decoration: ShapeDecoration(
            image: const DecorationImage(
              image: NetworkImage("https://placehold.co/297x292"),
              fit: BoxFit.cover,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.h),
            ),
            shadows: [
              BoxShadow(
                color: const Color(0x19FFFFFF),
                blurRadius: 2,
                offset: const Offset(0, 2.50),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color(0x3F000000),
                blurRadius: 4,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              // User name overlay at bottom
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  height: 56.h,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(0.50, 1.00),
                      end: const Alignment(0.50, 0.00),
                      colors: [
                        Colors.black.withOpacity(0.80),
                        Colors.black.withOpacity(0),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.h),
                      bottomRight: Radius.circular(16.h),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Anh Long Magic',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFA0B2F8),
                        fontSize: 40.fSize,
                        fontFamily: 'Alumni Sans',
                        fontWeight: FontWeight.w900,
                        height: 0.90,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankBadge() {
    return Positioned(
      left: 122.h,
      top: 446.h,
      child: Container(
        width: 185.h,
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 7.h),
        decoration: ShapeDecoration(
          color: const Color(0x2623195B),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFF1A1A50),
            ),
            borderRadius: BorderRadius.circular(6.h),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events,
              color: const Color(0xFF18117B),
              size: 14.h,
            ),
            SizedBox(width: 8.h),
            Text(
              'RANK : G',
              style: TextStyle(
                color: const Color(0xFF18117B),
                fontSize: 28.fSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                height: 0.71,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallAvatar() {
    return Positioned(
      right: 20.h,
      top: 456.h,
      child: Stack(
        children: [
          Container(
            width: 47.h,
            height: 47.h,
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: NetworkImage("https://placehold.co/47x47"),
                fit: BoxFit.cover,
              ),
              shape: OvalBorder(
                side: BorderSide(
                  width: 1,
                  color: const Color(0xFF060606),
                ),
              ),
            ),
          ),
          // Online indicator
          Positioned(
            bottom: -3.h,
            right: -3.h,
            child: Container(
              width: 20.h,
              height: 20.h,
              decoration: const ShapeDecoration(
                color: Color(0xFFFF004F),
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButtons() {
    return Positioned(
      right: 20.h,
      top: 550.h,
      child: Column(
        children: [
          // Views count
          Text(
            '328.7K',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.fSize,
              fontFamily: 'ABeeZee',
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                  offset: const Offset(1, 1),
                  blurRadius: 0,
                  color: Colors.black.withOpacity(0.30),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 30.h),
          
          // Play now button with heart effects
          Column(
            children: [
              Container(
                width: 50.h,
                height: 50.h,
                child: Stack(
                  children: [
                    // Heart effects (multiple small rectangles)
                    _buildHeartEffect(37.73.h, 10.h, 9.39.h, 0.83.h),
                    _buildHeartEffect(33.30.h, 13.h, 7.43.h, 0.83.h),
                    _buildHeartEffect(38.59.h, 15.h, 17.24.h, 1.67.h),
                    _buildHeartEffect(45.84.h, 10.h, 9.39.h, 0.83.h),
                    _buildHeartEffect(50.27.h, 13.h, 7.43.h, 0.83.h),
                    _buildHeartEffect(44.44.h, 14.h, 17.24.h, 1.67.h),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Chơi luôn',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.fSize,
                  fontFamily: 'ABeeZee',
                  fontWeight: FontWeight.w400,
                  shadows: [
                    Shadow(
                      offset: const Offset(1, 1),
                      blurRadius: 0,
                      color: Colors.black.withOpacity(0.30),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 40.h),
          
          // Schedule button
          Column(
            children: [
              Container(
                width: 45.34.h,
                height: 45.34.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.schedule,
                  color: Colors.white,
                  size: 24.h,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Lên lịch',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.fSize,
                  fontFamily: 'ABeeZee',
                  fontWeight: FontWeight.w400,
                  shadows: [
                    Shadow(
                      offset: const Offset(1, 1),
                      blurRadius: 0,
                      color: Colors.black.withOpacity(0.30),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 40.h),
          
          // Comments count
          Text(
            '578',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.fSize,
              fontFamily: 'ABeeZee',
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                  offset: const Offset(1, 1),
                  blurRadius: 0,
                  color: Colors.black.withOpacity(0.30),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 40.h),
          
          // Share button
          Column(
            children: [
              Icon(
                Icons.share,
                color: Colors.white,
                size: 24.h,
              ),
              SizedBox(height: 8.h),
              Text(
                'Share',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.fSize,
                  fontFamily: 'ABeeZee',
                  fontWeight: FontWeight.w400,
                  shadows: [
                    Shadow(
                      offset: const Offset(1, 1),
                      blurRadius: 0,
                      color: Colors.black.withOpacity(0.30),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
          
          // Additional count
          Text(
            '99',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.fSize,
              fontFamily: 'ABeeZee',
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                  offset: const Offset(1, 1),
                  blurRadius: 0,
                  color: Colors.black.withOpacity(0.30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeartEffect(double left, double top, double width, double height) {
    return Positioned(
      left: left - 30.h, // Adjust for container position
      top: top - 10.h,   // Adjust for container position
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: const Color(0xFFFF004F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.70.h),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomUserInfo() {
    return Positioned(
      left: 16.h,
      bottom: 120.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User avatar and info
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 50.h,
                    height: 50.h,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: NetworkImage("https://placehold.co/50x50"),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.83,
                          color: const Color(0xFF151516),
                        ),
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                    ),
                  ),
                  // Online indicator
                  Positioned(
                    bottom: -3.h,
                    right: -3.h,
                    child: Container(
                      width: 20.h,
                      height: 20.h,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFF004F),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SABO Billiards',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.fSize,
                      fontFamily: 'Aldrich',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Container(
                        width: 95.h,
                        height: 24.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF0A5C6D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.h),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Vũng Tàu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.fSize,
                              fontFamily: 'ABeeZee',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.h),
                      // Online dot
                      Container(
                        width: 8.41.h,
                        height: 1.55.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF5AD439).withOpacity(0.40),
                          shape: const OvalBorder(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Post info
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '@longsang · 03',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.fSize,
                    fontFamily: 'ABeeZee',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '-09',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.fSize,
                    fontFamily: 'ABeeZee',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 8.h),
          
          // Post description
          SizedBox(
            width: 329.h,
            child: Text(
              'Tìm đối tối nay             #sabo #rankG',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.fSize,
                fontFamily: 'ABeeZee',
                fontWeight: FontWeight.w400,
                height: 1.30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
