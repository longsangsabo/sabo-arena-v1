import 'package:flutter/material.dart';
import 'package:sang_s_application/core/app_export.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({Key? key}) : super(key: key);

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  bool isOpenTab = true; // true for "Mở rộng", false for "Nội bộ"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          _buildBackgroundImage(),
          
          // Header with SABO logo and icons
          _buildHeader(),
          
          // Tab selector (Mở rộng / Nội bộ)
          _buildTabSelector(),
          
          // Tournament Card
          _buildTournamentCard(),
          
          // Side Action Buttons (similar to TikTok)
          _buildSideActionButtons(),
          
          // Bottom User Info
          _buildBottomUserInfo(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: 414.h,
        height: 812.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://via.placeholder.com/414x812/1a1a1a/ffffff?text=Tournament+Background"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      left: 1.h,
      top: 50.h,
      child: Container(
        width: 413.h,
        height: 34.h,
        child: Stack(
          children: [
            // SABO Logo
            Positioned(
              left: 20.h,
              top: 0.h,
              child: Text(
                'SABO',
                style: TextStyle(
                  color: const Color(0xFF6403C8),
                  fontSize: 24.fSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.20,
                ),
              ),
            ),
            
            // Top right icons
            Positioned(
              right: 20.h,
              top: 0.h,
              child: Row(
                children: [
                  Icon(Icons.wb_sunny_outlined, color: Colors.white, size: 20.h),
                  SizedBox(width: 15.h),
                  Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20.h),
                  SizedBox(width: 15.h),
                  Icon(Icons.notifications_outlined, color: Colors.white, size: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Positioned(
      left: 0.h,
      top: 77.h,
      child: Container(
        width: 414.h,
        height: 44.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => setState(() => isOpenTab = true),
              child: Text(
                'Mở rộng',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isOpenTab ? Colors.white : const Color(0xFFD7D7D9),
                  fontSize: 16.fSize,
                  fontFamily: 'Lexend Exa',
                  fontWeight: isOpenTab ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 80.h),
            GestureDetector(
              onTap: () => setState(() => isOpenTab = false),
              child: Text(
                'Nội bộ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: !isOpenTab ? Colors.white : const Color(0xFFD7D7D9),
                  fontSize: 16.fSize,
                  fontFamily: 'Lexend Exa',
                  fontWeight: !isOpenTab ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentCard() {
    return Positioned(
      left: 34.h,
      top: 123.h,
      child: Container(
        width: 343.h,
        height: 403.h,
        decoration: ShapeDecoration(
          color: const Color(0xCC21262D),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 4,
              color: const Color(0xFF829DC1),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 6,
              offset: Offset(0, 4),
              spreadRadius: -4,
            ),
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 15,
              offset: Offset(0, 10),
              spreadRadius: -3,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tournament Title and Status
              _buildTournamentHeader(),
              
              SizedBox(height: 16.h),
              
              // Tournament Details
              _buildTournamentDetails(),
              
              SizedBox(height: 16.h),
              
              // Prize Pool
              _buildPrizePool(),
              
              SizedBox(height: 16.h),
              
              // Tournament Info (Date, Location, Deadline)
              _buildTournamentInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTournamentHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SABO POOL 9 Ball',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Open',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Mở đăng ký',
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildTournamentDetails() {
    return Column(
      children: [
        // Trophy and participants
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events, color: const Color(0xFFEAB308), size: 16.h),
                SizedBox(width: 8.h),
                Text(
                  '2 Mạng',
                  style: TextStyle(
                    color: const Color(0xFFE5E7EB),
                    fontSize: 14.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Text(
              '9-Ball',
              style: TextStyle(
                color: const Color(0xFFE5E7EB),
                fontSize: 14.fSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        
        SizedBox(height: 8.h),
        
        // Participants and available slots
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.people, color: const Color(0xFF60A5FA), size: 16.h),
                SizedBox(width: 8.h),
                Text(
                  '0/16 người',
                  style: TextStyle(
                    color: const Color(0xFFE5E7EB),
                    fontSize: 14.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.h),
              decoration: ShapeDecoration(
                color: const Color(0xFF238636),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              child: Text(
                'Còn 16 chỗ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        
        SizedBox(height: 8.h),
        
        // Rank requirement
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: const Color(0xFFC084FC), size: 16.h),
                SizedBox(width: 8.h),
                Text(
                  'Hạng tham gia:',
                  style: TextStyle(
                    color: const Color(0xFFE5E7EB),
                    fontSize: 14.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Text(
              'Hạng K → Hạng G+',
              style: TextStyle(
                color: const Color(0xFFC084FC),
                fontSize: 14.fSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        SizedBox(height: 8.h),
        
        // Entry fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.h),
              child: Text(
                'Lệ phí tham gia:',
                style: TextStyle(
                  color: const Color(0xFFE5E7EB),
                  fontSize: 14.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              '300.000 đ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.fSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrizePool() {
    return Center(
      child: Container(
        width: 225.h,
        height: 69.h,
        padding: EdgeInsets.all(13.h),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, 0.00),
            end: Alignment(0.50, 1.00),
            colors: [const Color(0x4CD29922), const Color(0x19D29922)],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: const Color(0x66D29922),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TỔNG GIẢI THƯỞNG',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFEAB308),
                fontSize: 12.fSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                letterSpacing: 1.20,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '10.000.000',
                  style: TextStyle(
                    color: const Color(0xFFEAB308),
                    fontSize: 30.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(
                    'đ',
                    style: TextStyle(
                      color: const Color(0xFFEAB308),
                      fontSize: 20.fSize,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentInfo() {
    return Column(
      children: [
        // Date
        Row(
          children: [
            Icon(Icons.schedule, color: const Color(0xFF9CA3AF), size: 16.h),
            SizedBox(width: 12.h),
            Text(
              '09:03 06/09/2025',
              style: TextStyle(
                color: const Color(0xFFD1D5DB),
                fontSize: 14.fSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        
        SizedBox(height: 12.h),
        
        // Location
        Row(
          children: [
            Icon(Icons.location_on, color: const Color(0xFF9CA3AF), size: 16.h),
            SizedBox(width: 12.h),
            Text(
              '601A Nguyễn An Ninh - TP Vũng Tàu',
              style: TextStyle(
                color: const Color(0xFFD1D5DB),
                fontSize: 14.fSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        
        SizedBox(height: 12.h),
        
        // Registration deadline
        Row(
          children: [
            Icon(Icons.access_time, color: const Color(0xFF9CA3AF), size: 16.h),
            SizedBox(width: 12.h),
            Text(
              'Hạn ĐK: 21:04 30/08/2025',
              style: TextStyle(
                color: const Color(0xFFD1D5DB),
                fontSize: 14.fSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSideActionButtons() {
    return Positioned(
      right: 15.h,
      top: 550.h,
      child: Column(
        children: [
          _buildActionButton(
            icon: Icons.favorite_border,
            count: '328.7K',
            onTap: () {},
          ),
          SizedBox(height: 30.h),
          _buildActionButton(
            icon: Icons.chat_bubble_outline,
            count: '578',
            onTap: () {},
          ),
          SizedBox(height: 30.h),
          _buildActionButton(
            icon: Icons.share,
            count: '99',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 35.h,
            height: 35.h,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20.h,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            count,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.fSize,
              fontFamily: 'ABeeZee',
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
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

  Widget _buildBottomUserInfo() {
    return Positioned(
      left: 17.h,
      bottom: 100.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User avatar and info
          Row(
            children: [
              Container(
                width: 50.h,
                height: 50.h,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/50x50/333333/ffffff?text=SB"),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.83,
                      color: const Color(0xFF151516),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              
              // Active indicator
              Positioned(
                right: -5.h,
                bottom: -5.h,
                child: Container(
                  width: 20.h,
                  height: 20.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFF004F),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              
              SizedBox(width: 16.h),
              
              // Club name and location
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.h),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF0A5C6D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
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
                ],
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // Tournament description
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '@sabobilliards',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.fSize,
                    fontFamily: 'ABeeZee',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: ' · 03-09',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.60),
                    fontSize: 17.fSize,
                    fontFamily: 'ABeeZee',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 8.h),
          
          Text(
            'Giải đấu tuần này              #sabo #rankG',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.fSize,
              fontFamily: 'ABeeZee',
              fontWeight: FontWeight.w400,
              height: 1.30,
            ),
          ),
        ],
      ),
    );
  }
}
