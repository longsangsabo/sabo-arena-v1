import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Background image
            _buildBackgroundImage(),
            
            // Top header
            _buildTopHeader(),
            
            // Tab navigation
            _buildTabNavigation(),
            
            // Main content (user card)
            _buildUserCard(),
            
            // Rank badge
            _buildRankBadge(),
            
            // Side action buttons
            _buildSideActionButtons(),
            
            // Bottom user info
            _buildBottomUserInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: 414.h,
        height: 813.h,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: NetworkImage("https://placehold.co/414x813"),
            fit: BoxFit.cover,
          ),
          boxShadow: [
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
        child: Stack(
          children: [
            // SABO logo
            Positioned(
              left: 20.h,
              top: -4.h,
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
            
            // Icons on the right
            Positioned(
              right: 36.h,
              top: 0,
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny_outlined,
                    color: Colors.white,
                    size: 20.h,
                  ),
                  SizedBox(width: 26.h),
                  Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 20.h,
                  ),
                  SizedBox(width: 26.h),
                  Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabNavigation() {
    return Positioned(
      left: 0,
      top: 77.h,
      child: Container(
        width: 414.h,
        height: 44.h,
        child: Stack(
          children: [
            Positioned(
              left: 88.h,
              top: 13.h,
              child: Text(
                'Lân cận',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.fSize,
                  fontFamily: 'Lexend Exa',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              left: 232.h,
              top: 13.h,
              child: Opacity(
                opacity: 0.80,
                child: Text(
                  'Đã Follow',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFD7D7D9),
                    fontSize: 16.fSize,
                    fontFamily: 'Lexend Exa',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return Positioned(
      left: 66.h,
      top: 130.h,
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
      left: 124.h,
      top: 454.h,
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

  Widget _buildSideActionButtons() {
    return Positioned(
      right: 20.h,
      top: 550.h,
      child: Column(
        children: [
          // Heart button
          _buildActionButton(
            icon: Icons.favorite_border,
            count: '328.7K',
            color: Colors.white,
          ),
          SizedBox(height: 30.h),
          
          // Comment button
          _buildActionButton(
            icon: Icons.chat_bubble_outline,
            count: '578',
            color: Colors.white,
          ),
          SizedBox(height: 30.h),
          
          // Share button
          _buildActionButton(
            icon: Icons.share,
            count: '99',
            color: Colors.white,
          ),
          SizedBox(height: 10.h),
          
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
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String count,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 40.h,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24.h,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          count,
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
    );
  }

  Widget _buildBottomUserInfo() {
    return Positioned(
      left: 17.h,
      bottom: 120.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Club info section
          Row(
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
                child: Stack(
                  children: [
                    Positioned(
                      right: -3.h,
                      bottom: -3.h,
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
                  SizedBox(height: 5.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.h),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF0A5C6D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8.41.h,
                          height: 1.55.h,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF5AD439).withOpacity(0.40),
                            shape: const OvalBorder(),
                          ),
                        ),
                        SizedBox(width: 8.h),
                        Text(
                          'Vũng Tàu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.fSize,
                            fontFamily: 'ABeeZee',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          // User info and caption
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
