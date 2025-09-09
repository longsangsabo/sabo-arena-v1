import 'package:flutter/material.dart';

/// Club Screen
class ClubScreen extends StatefulWidget {
  const ClubScreen({Key? key}) : super(key: key);

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Club',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.groups,
              size: 64,
              color: Color(0xFF45454E),
            ),
            SizedBox(height: 16),
            Text(
              'Club',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tham gia và tạo club cùng bạn bè',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF45454E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
