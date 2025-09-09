import 'package:flutter/material.dart';

/// Profile Screen
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hồ Sơ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xFF161722),
              child: Icon(
                Icons.person,
                size: 48,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Hồ Sơ Cá Nhân',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Xem và chỉnh sửa thông tin cá nhân',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8A8B8F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
