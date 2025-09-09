import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              // Header with username
              _buildHeader(),
              
              // User profile section
              _buildUserProfileSection(),
              
              // Match status tabs
              _buildMatchStatusTabs(),
              
              // Tournament list
              _buildTournamentList(),
              
              // Bottom spacing for navigation
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 88.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD0D1D3),
            blurRadius: 0,
            offset: const Offset(0, 0.33),
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Text(
              '@longsang',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF161722),
                fontSize: 17.fSize,
                fontFamily: 'ABeeZee',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return Container(
      margin: EdgeInsets.fromLTRB(-4.h, 0, -4.h, 0),
      width: 418.h,
      height: 538.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD0D1D3),
            blurRadius: 0,
            offset: const Offset(0, 0.33),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          // User image with gradient border
          _buildUserImage(),
          
          // Rank badge
          _buildRankBadge(),
          
          // Statistics
          _buildUserStatistics(),
          
          // Floating camera button
          _buildFloatingCameraButton(),
        ],
      ),
    );
  }

  Widget _buildUserImage() {
    return Positioned(
      left: 35.h,
      top: 16.h,
      child: Container(
        width: 350.h,
        height: 350.h,
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
              image: NetworkImage("https://placehold.co/345x345"),
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
                  height: 76.h,
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
                        fontSize: 50.fSize,
                        fontFamily: 'Alumni Sans',
                        fontWeight: FontWeight.w900,
                        height: 0.72,
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
      left: 118.h,
      top: 389.h,
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
            Container(
              width: 14.h,
              height: 14.h,
              child: Icon(
                Icons.emoji_events,
                color: const Color(0xFF18117B),
                size: 14.h,
              ),
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

  Widget _buildUserStatistics() {
    return Positioned(
      left: 27.h,
      top: 457.h,
      child: Container(
        width: 364.h,
        padding: EdgeInsets.only(left: 28.67.h, right: 28.72.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('1485', 'ELO'),
            _buildStatItem('320', 'SPA'),
            _buildStatItem('#89', 'XH'),
            _buildStatItem('37', 'TRẬN'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF445154),
            fontSize: 18.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 1.56,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF071122),
            fontSize: 12.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.33,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingCameraButton() {
    return Positioned(
      right: 10.h,
      top: 352.h,
      child: Container(
        width: 52.h,
        height: 52.h,
        decoration: ShapeDecoration(
          color: const Color(0xFFF5F5F5),
          shape: OvalBorder(
            side: BorderSide(width: 5, color: Colors.white),
          ),
        ),
        child: const Icon(
          Icons.camera_alt,
          color: Color(0xFF161722),
          size: 24,
        ),
      ),
    );
  }

  Widget _buildMatchStatusTabs() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 40.h, 0, 0),
      width: 414.h,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD0D1D3),
            blurRadius: 0,
            offset: const Offset(0, 0.33),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ready',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF0A5C6D),
                      fontSize: 17.fSize,
                      fontFamily: 'ABeeZee',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    width: 47.h,
                    height: 2.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0A5C6D),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Live',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFD7D7D9),
                  fontSize: 17.fSize,
                  fontFamily: 'ABeeZee',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Done',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFD7D7D9),
                  fontSize: 17.fSize,
                  fontFamily: 'ABeeZee',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTournamentList() {
    return Container(
      margin: EdgeInsets.fromLTRB(36.h, 38.h, 31.h, 0),
      child: Column(
        children: [
          _buildTournamentItem(),
          SizedBox(height: 17.h),
          _buildTournamentItem(),
        ],
      ),
    );
  }

  Widget _buildTournamentItem() {
    return Container(
      width: 347.h,
      height: 50.h,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.07),
          ),
          borderRadius: BorderRadius.circular(10.h),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 4,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Ball icon (8-ball)
          _buildBallIcon(),
          
          // Tournament info
          _buildTournamentInfo(),
          
          // Lives indicator
          _buildLivesIndicator(),
        ],
      ),
    );
  }

  Widget _buildBallIcon() {
    return Positioned(
      left: 5.h,
      top: 5.h,
      child: Container(
        width: 40.h,
        height: 40.h,
        decoration: ShapeDecoration(
          gradient: const RadialGradient(
            center: Alignment(0.50, 0.50),
            radius: 1.31,
            colors: [Colors.black, Colors.black],
          ),
          shape: const OvalBorder(),
          shadows: [
            BoxShadow(
              color: const Color(0x99000000),
              blurRadius: 8,
              offset: const Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 10.h,
              top: 10.h,
              child: Container(
                width: 20.h,
                height: 20.h,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                ),
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.fSize,
                      fontFamily: 'Acme',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentInfo() {
    return Positioned(
      left: 60.h,
      top: 0,
      child: Container(
        width: 240.h,
        height: 47.h,
        child: Stack(
          children: [
            // Tournament title
            Positioned(
              left: 0,
              top: 0,
              child: Text(
                'SABO POOL 8 BALL',
                style: TextStyle(
                  color: const Color(0xFF0A5C6D),
                  fontSize: 14.fSize,
                  fontFamily: 'ABeeZee',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            
            // Date
            Positioned(
              left: 18.h,
              top: 34.h,
              child: Text(
                '07/09 - Thứ 7',
                style: TextStyle(
                  color: const Color(0xFF0A5C6D),
                  fontSize: 10.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 2,
                ),
              ),
            ),
            
            // Level
            Positioned(
              left: 126.h,
              top: 6.h,
              child: Text(
                'K - I+',
                style: TextStyle(
                  color: const Color(0xFF0A5C6D),
                  fontSize: 12.fSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.67,
                  letterSpacing: -0.15,
                ),
              ),
            ),
            
            // Players count
            Positioned(
              left: 71.h,
              top: 32.h,
              child: Text(
                '0/16',
                style: TextStyle(
                  color: const Color(0xFF801515),
                  fontSize: 10.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 2,
                ),
              ),
            ),
            
            // Prize
            Positioned(
              left: 132.h,
              top: 30.h,
              child: Text(
                '10 Million',
                style: TextStyle(
                  color: const Color(0xFF801515),
                  fontSize: 10.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 2,
                ),
              ),
            ),
            
            // Join button
            Positioned(
              right: 0,
              top: 23.h,
              child: Container(
                width: 45.h,
                height: 22.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFF7F1516),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.h),
                  ),
                  shadows: [
                    BoxShadow(
                      color: const Color(0x1C000000),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: const Color(0xFF468E9C),
                      blurRadius: 4,
                      offset: const Offset(-2, -2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'JOIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.fSize,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLivesIndicator() {
    return Positioned(
      right: 8.h,
      top: 2.h,
      child: Text(
        '2 Mạng',
        style: TextStyle(
          color: const Color(0xFF0A5C6D),
          fontSize: 10.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          height: 2,
        ),
      ),
    );
  }
}
