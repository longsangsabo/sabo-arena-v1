import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class ClubProfileScreen extends StatelessWidget {
  const ClubProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              // Header with club name
              _buildHeader(),
              
              // Club image with gradient border
              _buildClubImage(),
              
              // Location info
              _buildLocationInfo(),
              
              // Statistics row
              _buildStatistics(),
              
              // Divider
              _buildDivider(),
              
              // Members list
              _buildMembersList(),
              
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
              '@sabobilliards',
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

  Widget _buildClubImage() {
    return Container(
      margin: EdgeInsets.fromLTRB(35.h, 16.h, 38.h, 0),
      child: Container(
        width: 346.h,
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
                      'SABO Billiards',
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

  Widget _buildLocationInfo() {
    return Container(
      margin: EdgeInsets.fromLTRB(105.h, 32.h, 91.h, 0),
      child: Container(
        width: 218.h,
        height: 35.h,
        decoration: ShapeDecoration(
          color: const Color(0x1E1E1775),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 11.76.h,
                height: 2.18.h,
                margin: EdgeInsets.only(right: 8.h),
                decoration: ShapeDecoration(
                  color: const Color(0xFFBA1800).withOpacity(0.40),
                  shape: const OvalBorder(),
                ),
              ),
              Text(
                '601A Nguyễn An Ninh - TP Vũng Tàu',
                style: TextStyle(
                  color: const Color(0xFF081122),
                  fontSize: 16.fSize,
                  fontFamily: 'Agdasima',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Container(
      margin: EdgeInsets.fromLTRB(46.h, 24.h, 46.h, 0),
      width: 335.h,
      height: 48.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('25', 'Thành viên'),
          _buildStatItem('15', 'Giải đấu'),
          _buildStatItem('89.9 Tr', 'Prize Pool'),
          _buildStatItem('37', 'Thách đấu'),
        ],
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
            fontSize: number.contains('Tr') ? 16.fSize : 18.fSize,
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

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.h, 24.h, 40.h, 0),
      width: 48.h,
      height: 2.h,
      decoration: const BoxDecoration(
        color: Color(0xFF161722),
      ),
    );
  }

  Widget _buildMembersList() {
    return Container(
      margin: EdgeInsets.fromLTRB(22.h, 24.h, 22.h, 0),
      child: Column(
        children: [
          _buildMemberItem(
            name: 'Anh Long Magic',
            rank: 'Rank G',
            date: '04/09/2025',
            avatar: 'https://placehold.co/47x47',
          ),
          SizedBox(height: 5.h),
          _buildMemberItem(
            name: 'SABO',
            rank: 'Rank H',
            date: '04/09/2025',
            avatar: 'https://placehold.co/47x47',
          ),
        ],
      ),
    );
  }

  Widget _buildMemberItem({
    required String name,
    required String rank,
    required String date,
    required String avatar,
  }) {
    return Container(
      width: 375.h,
      height: 76.h,
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          // Avatar
          Positioned(
            left: 20.h,
            top: 14.h,
            child: Container(
              width: 47.h,
              height: 47.h,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(avatar),
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
          ),
          
          // Name
          Positioned(
            left: 87.h,
            top: 17.h,
            child: SizedBox(
              width: 235.h,
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.fSize,
                  fontFamily: 'ABeeZee',
                  fontWeight: FontWeight.w400,
                  height: 1.29,
                  letterSpacing: -0.40,
                ),
              ),
            ),
          ),
          
          // Rank
          Positioned(
            left: 88.h,
            top: 39.h,
            child: SizedBox(
              width: 235.h,
              height: 20.h,
              child: Text(
                rank,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.50),
                  fontSize: 14.fSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                  letterSpacing: -0.15,
                ),
              ),
            ),
          ),
          
          // Date
          Positioned(
            left: 240.h,
            top: 34.h,
            child: SizedBox(
              width: 116.h,
              height: 34.h,
              child: Text(
                date,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.fSize,
                  fontFamily: 'NATS',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          
          // Joshua text (seems to be a watermark or placeholder)
          Positioned(
            left: 8.h,
            top: 67.h,
            child: SizedBox(
              width: 65.h,
              child: Text(
                'Joshua',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.35),
                  fontSize: 13.fSize,
                  fontFamily: 'SF Pro Text',
                  fontWeight: FontWeight.w400,
                  height: 1.38,
                  letterSpacing: -0.08,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
